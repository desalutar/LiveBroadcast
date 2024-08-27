//
//  ViewModel.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 27.05.24.
//

import AVFoundation
import Foundation
import CoreImage

class CameraManager: NSObject {
    private let captureSession = AVCaptureSession() //  выполняет захват в режиме реального времени и добавляет соответствующие входные и выходные данные
    private var deviceInput: AVCaptureDeviceInput? //описывающий ввод мультимедиа с устройства захвата в сеанс захвата

    private var videoOutput: AVCaptureVideoDataOutput? // объект, используемый для доступа к видеокадрам для обработки
    private let systemPreferredCamera = AVCaptureDevice.default(for: .video) // объект представляет аппаратное или виртуальное устройство захвата, которое может предоставлять один или несколько потоков мультимедиа определенного типа
    private var sessionQueue = DispatchQueue(label: "video.preview.session") // Обязательно использовать очередь последовательной отправки, чтобы гарантировать, что видеокадры будут доставлены по порядку.
    
    private var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            var isAuthorized = status == .authorized
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            return isAuthorized
        }
    }
    
    private var addToPreviewStream: ((CGImage) -> Void)?
    
    lazy var previewStream: AsyncStream<CGImage> = {
        AsyncStream { continuation in
            addToPreviewStream = { cgImage in
                continuation.yield(cgImage)
            }
        }
    }()
    
    override init() {
        super.init()
        
        Task {
            await configureSession()
            await startSession()
        }
    }
    
    private func configureSession() async {
        guard await isAuthorized,
              let systemPreferredCamera,
              let deviceInput = try? AVCaptureDeviceInput(device: systemPreferredCamera) else { return
        }
        captureSession.beginConfiguration()
        defer {
            self.captureSession.commitConfiguration()
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        
        guard captureSession.canAddInput(deviceInput) else {
            print("Unable to add device input to capture session")
            return
        }
        
        guard captureSession.canAddOutput(videoOutput) else {
            print("Unable to add video output to capture session")
            return
        }
        
        captureSession.addInput(deviceInput)
        captureSession.addOutput(videoOutput)
        if let connection = videoOutput.connection(with: .video) {
            let desiredRotationAngle: CGFloat = 90.0
            if connection.isVideoRotationAngleSupported(desiredRotationAngle) {
                connection.videoRotationAngle = desiredRotationAngle
            } else {
                print("The desired rotation angle \(desiredRotationAngle) is not supported.")
            }
        }
    }
    
    private func startSession() async {
        guard await isAuthorized else { return }
        captureSession.startRunning()
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let currentFrame = sampleBuffer.cgImage else { return }
        addToPreviewStream?(currentFrame)
    }
}

extension CMSampleBuffer {
    var cgImage: CGImage? {
        let pixelBuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(self)
        guard let imagePixelBuffer = pixelBuffer else { return nil }
        
        return CIImage(cvPixelBuffer: imagePixelBuffer).cgImage
    }
}

extension CIImage {
    var cgImage: CGImage? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else {
            return nil
        }
        return cgImage
    }
}

@Observable
class CameraViewModel {
    var currentFrame: CGImage?
    private let cameraManager = CameraManager()
    init() {
        Task {
            await handleCameraPreview()
        }
    }
    
    func handleCameraPreview() async {
        for await image in cameraManager.previewStream {
            Task { @MainActor in
                currentFrame = image
            }
        }
    }
}
