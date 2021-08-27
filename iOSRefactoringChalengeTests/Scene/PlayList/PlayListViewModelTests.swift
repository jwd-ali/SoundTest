import Combine
import XCTest
@testable import iOSRefactoringChallenge
class PlayListViewModelTests: XCTestCase {
    private var sut: PlayListViewModel!
    private var cancellables: Set<AnyCancellable>!
    override func setUpWithError() throws {
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        sut = nil
        cancellables = nil
        try super.tearDownWithError()
    }
    
    func test_view_model_creation_success() {
        let apiClient = MockAPIClient()
        let service = PlayListService(apiClient: apiClient)
        let repository = RemotePlayListRepository(service: service, mapper: TrackMapper())
        sut = PlayListViewModel(repository: repository)
        sut.refreshPlaylist.send(())
        XCTAssertFalse(sut.cellViewModels.value.isEmpty)
    }
    
    func test_error_case() {
        let repository = MockFailurePlayListRepository()
        sut = PlayListViewModel(repository: repository)
      
        let expectation = self.expectation(description: "Finishes without publishing values")
        sut.error
            .sink{ value in
                XCTAssertNotNil(value)
                expectation.fulfill()
            }
        .store(in: &cancellables)
        sut.refreshPlaylist.send(())
        waitForExpectations(timeout: 5)
    }
}
