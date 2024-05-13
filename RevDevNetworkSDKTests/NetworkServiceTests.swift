import XCTest
@testable import RevDevNetworkSDK

final class NetworkServiceTests: XCTestCase {
    
//    func testFetchDataSuccess() {
//        // Given
//        let url = URL(string: "https://example.com")!
//        let networkService = NetworkService(networkDelegate: MockNetworkDelegate())
//        
//        // When
//        let expectation = XCTestExpectation(description: "Fetch data from URL")
//        networkService.fetchData(url: url) { (result: Result<Data, Error>) in
//            // Then
//            switch result {
//            case .success(let data):
//                XCTAssertNotNil(data)
//                expectation.fulfill()
//            case .failure(let error):
//                XCTFail("Fetching data failed with error: \(error.localizedDescription)")
//            }
//        }
//        
//        wait(for: [expectation], timeout: 10.0)
//    }
    
    func testFetchDataFailure() {
        // Given
        let url = URL(string: "https://nonexistentdomain.com")!
        let networkService = NetworkService()
        
        // When
        let expectation = XCTestExpectation(description: "Fetch data from invalid URL")
        networkService.fetchData(url: url) { (result: Result<Data, Error>) in
            // Then
            switch result {
            case .success(_):
                XCTFail("Fetching data succeeded unexpectedly")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    // Add more test cases as needed
}
