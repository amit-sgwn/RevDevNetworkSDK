import XCTest
@testable import RevDevNetworkSDK

final class CacheProtocolTests: XCTestCase {
    func testURLCacheWrapper() {
        // Given
        let urlCache = URLCache()
        let cache = URLCacheWrapper(cache: urlCache)
        let request = URLRequest(url: URL(string: "https://example.com")!)
        let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let data = Data("Test data".utf8)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        
        // When
        cache.storeCachedResponse(cachedResponse, for: request)
        let retrievedResponse = cache.cachedResponse(for: request)
        
        // Then
        XCTAssertEqual(retrievedResponse?.data, data)
    }
}
