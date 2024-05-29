//
//  CIImage + Extension.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 27.05.24.
//

import CoreImage

extension CIImage {
    var cgImage: CGImage? {
        let ciContext = CIContext()
        
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else { return nil }
        
        return cgImage
    }
}
