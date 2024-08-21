//
//  CameraManager.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 27.05.24.
//

import Foundation
import AVFoundation

class CameraManager: NSObject {
    override init() {
        super.init()
        
        Task {
            await configureSession()
            await startSession()
        }
    }
    
    // объект который выполняет захват в реальном времени и + соответствующие входные и вых. данные
    private let captureSession = AVCaptureSession()
    
    // параметр AVCaptureDeviceInput описывает ввод мультимедиа с устройства захвата в сеанс захвата
    private var deviceInput: AVCaptureDeviceInput?
    
    // AVCaptureVideoDataOutput объект используется для доступа к видеокадрам для обработки
    private var videoOutput: AVCaptureVideoDataOutput?
    
    /* AVCaptureDevice объект представляет аппаратное или виртуальное устройство
     захвата которое может предоставлять один или несколько потоков мультимедиа определенного типа */
    private let systemPreferredCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    
    // очередь для которой должны быть вызваны AVCaptureVideoDataOutputSampleBufferDelegate обратные вызовы
    /* обязательно использовать очередь последовательной отправки
     чтобы гарантировать что видеокадры будут доставлены по порядку */
    private var sessionQueue = DispatchQueue(label: "video.preview.session")
    
    private var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            // Определите, разрешил ли пользователь ранее доступ к камере
            var isAuthorized = status == .authorized
            
            // Если система не определила статус авторизации пользователя,
            // явно запрашиваем у них одобрение.
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
    
    // Функция отвечает за инициализацию всех свойств и определение делегата буфера
    private func configureSession() async {
        /*
         Проверяет авторизацию пользователя доступна ли выбранная камера 
         и может ли она принимать входные данные через AVCaptureDeviceInput объект
        */
        guard await isAuthorized,
              let systemPreferredCamera,
              let deviceInput = try? AVCaptureDeviceInput(device: systemPreferredCamera) else { return }
       
        // запуск настройки
        captureSession.beginConfiguration()
        
        // В конце выполнения метода конфигурации фиксируется в текущем сеансе
        defer {
            self.captureSession.commitConfiguration()
        }
        
        // Определяет видеовыход и задает делегат буфера выборки и очередь для вызова обратных вызовов
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        
        // Проверяет можно ли добавить входные данные в сеанс захвата
        guard captureSession.canAddInput(deviceInput) else {
            print("Unable to add device input to capture session.")
            return
        }
        
        // Проверяет можно ли добавить выходные данные
        guard captureSession.canAddOutput(videoOutput) else {
            print("Unable to add video output to capture session.")
            return
        }
        
        // Добавляет входные и выходные данные в AVCaptureSession
        captureSession.addInput(deviceInput)
        captureSession.addOutput(videoOutput)
        
        // Устанавливает ориентацию камера
        if let connection = videoOutput.connection(with: .video) {
            let desiredRotationAngle: CGFloat = 90.0
            if connection.isVideoRotationAngleSupported(desiredRotationAngle) {
                connection.videoRotationAngle = desiredRotationAngle
            } else {
                print("The desired rotation angle \(desiredRotationAngle) is not supported.")
            }
        }
    }
    
    // Отвечает только за запуск сеанса съемки
    private func startSession() async {
        // Проверка авторизации
        guard await isAuthorized else { return }
        // Pапуск потока данных сеанса захвата 
        captureSession.startRunning()
    }
    
    func switchCamera() async {
        
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    // Функция captureOutput(_:didOutput:from:) вызывается всякий раз, когда камера захватывает новый видеокадр.
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let currentFrame = sampleBuffer.cgImage else { return }
        addToPreviewStream?(currentFrame)
    }
}
