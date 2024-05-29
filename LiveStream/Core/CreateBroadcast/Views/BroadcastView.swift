//
//  CreateBroadcast.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 26.05.24.
//

import SwiftUI

struct BroadcastView: View {
    @Binding var image: CGImage?
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack {
                    if let image = image {
                        Image(decorative: image, scale: 1)
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.top)
                            .scaleEffect(x: -1)
                    } else {
                        ContentUnavailableView("No camera feed", systemImage: "xmark.circle.fill")
                    }
                }
                BroadcastButtons()
            }
        }
    }
}


func createTestImage() -> CGImage {
    let size = CGSize(width: 100, height: 100)
    UIGraphicsBeginImageContext(size)
    let context = UIGraphicsGetCurrentContext()!
    
    // Заполняем его каким-то цветом для визуализации
    context.setFillColor(UIColor.blue.cgColor)
    context.fill(CGRect(origin: .zero, size: size))
    
    let cgImage = context.makeImage()!
    UIGraphicsEndImageContext()
    return cgImage
}


struct CreateBroadcast_Previews: PreviewProvider {
    @State static var testImage: CGImage? = createTestImage()
    
    static var previews: some View {
        BroadcastView(image: $testImage)
    }
}
