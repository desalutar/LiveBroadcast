//
//  CMSampleBuffer +Extension.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 27.05.24.
//

import AVFoundation
import CoreImage

extension CMSampleBuffer {
    var cgImage: CGImage? {
        let pixelBuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(self)
        
        guard let imagePixelBuffer = pixelBuffer else {
            return nil
        }
        return CIImage(cvPixelBuffer: imagePixelBuffer).cgImage
    }
}
