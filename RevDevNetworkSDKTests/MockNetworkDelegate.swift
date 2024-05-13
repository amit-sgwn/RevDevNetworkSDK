import XCTest
@testable import RevDevNetworkSDK

final class MockNetworkDelegate: NSObject, URLSessionDelegate {
    var didReceiveChallengeCalled = false

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        didReceiveChallengeCalled = true
        completionHandler(.performDefaultHandling, nil)
    }
    
}

final class MockUrlSession: URLSession {
   
}
