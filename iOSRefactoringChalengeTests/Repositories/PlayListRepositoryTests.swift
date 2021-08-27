import Combine
@testable import iOSRefactoringChallenge
import XCTest

class PlayListRepositoryTests: XCTestCase {
    private var sut: PlayListRepositoryType!
    private var service: PlayListServiceType!
    private var cancellables: Set<AnyCancellable>!
    private let fakeID = "789"
    override func setUpWithError() throws {
        cancellables = []
        let apiClient =  MockAPIClient()
        service = PlayListService(apiClient: apiClient)
    }
    
    func testRepositoryFailure() {
        sut = MockFailurePlayListRepository()
        
        var error: Error?
        var response: [TrackType]?
        let expectation = self.expectation(description: "RepositorySuccessTest")
        
        sut.getPlayList(with: fakeID)
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
        
        XCTAssertNotNil(error)
        XCTAssertNil(response)
    }
    
    func testRepositorySuccess() {
        sut = RemotePlayListRepository(service: service, mapper: TrackMapper())
        
        var error: Error?
        var response: [TrackType]?
        let expectation = self.expectation(description: "RepositorySuccessTest")
        
        sut.getPlayList(with: fakeID)
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
    
    override func tearDownWithError() throws {
       cancellables = nil
        service = nil
        sut = nil
        try super.tearDownWithError()
    }
    
}
