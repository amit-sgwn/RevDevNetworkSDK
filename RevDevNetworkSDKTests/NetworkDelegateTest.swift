import XCTest
@testable import RevDevNetworkSDK

final class NetworkDelegateTests: XCTestCase {

    func testDidReceiveChallenge() {
        // Given
        let mockDelegate = MockNetworkDelegate()
        let session = URLSession(configuration: .default, delegate: mockDelegate, delegateQueue: nil)
        
        // When
        session.delegate?.urlSession?(session, didReceive: URLAuthenticationChallenge(), completionHandler: { _, _ in })

        // Then
        XCTAssertTrue(mockDelegate.didReceiveChallengeCalled)
    }
}
