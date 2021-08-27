import XCTest
import Combine
@testable import iOSRefactoringChallenge
class APIClientTests: XCTestCase {
    private var sut: MockAPIClient!
    private var cancellables: Set<AnyCancellable>!
    override func setUpWithError() throws {
        cancellables = []
        self.sut = MockAPIClient()
    }

    override func tearDownWithError() throws {
        sut = nil
        cancellables = nil
        try super.tearDownWithError()
    }


    func testResponseSuccess() {
        var error: Error?
        var response: TracksResponse?
        let expectation = self.expectation(description: "ApiClientTest")
        
        sut.request(router: Endpoint(route: Route.getPlayList, method: .get))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                expectation.fulfill()
            }, receiveValue: { value in
                response = value
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNil(error)
        XCTAssertNotNil(response)
    }

}
