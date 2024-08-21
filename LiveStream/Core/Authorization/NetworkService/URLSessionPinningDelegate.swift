//
//  URLSessionPinningDelegate.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 08.08.24.
//

import Foundation
import Security

class URLSessionPinningDelegate: NSObject, URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                var error: CFError?
                let status = SecTrustEvaluateWithError(serverTrust, &error)
                if status == (error != nil) {
                    print("Error evaluating trust: \(String(describing: error))")
                } else {
                    // server certificate
                    if let certificateChain = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate] {
                        let serverCertificate = certificateChain.first
                        let serverCertificateData = SecCertificateCopyData(serverCertificate!)
                        let data = CFDataGetBytePtr(serverCertificateData)!
                        let size = CFDataGetLength(serverCertificateData)
                        let cert1 = Data(bytes: data, count: size)
                        
                        // bundled certificate
                        let file_der = Bundle.main.path(forResource: "certificate", ofType: "der")
                        if let file = file_der {
                            if let cert2 = try? Data(contentsOf: URL(fileURLWithPath: file)) {
                                // bundled certificate matches server's actual certificate
                                if cert1 == cert2 {
                                    completionHandler(.useCredential, URLCredential(trust: serverTrust))
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
        // Certificate validation / Pinning failed
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}
