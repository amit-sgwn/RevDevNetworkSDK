//
//  NetworkServices.swift
//  Medico
//
//  Created by Amit Kumar on 07/05/24.
//

import Foundation

open class NetworkDelegate: NSObject, URLSessionDelegate {
    open func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    
        switch challenge.protectionSpace.authenticationMethod {
        case NSURLAuthenticationMethodServerTrust:
            if let serverTrust = challenge.protectionSpace.serverTrust {
                let credential = URLCredential(trust: serverTrust)
                completionHandler(.useCredential, credential)
                return
            }
        default:
            completionHandler(.performDefaultHandling, nil)
        }
    }
    
    
}
