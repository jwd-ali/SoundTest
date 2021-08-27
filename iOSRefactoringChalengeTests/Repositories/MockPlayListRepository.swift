import Combine
import Foundation
@testable import iOSRefactoringChallenge

class MockFailurePlayListRepository: PlayListRepositoryType {
    func getPlayList(with ID: String) -> AnyPublisher<[TrackType], DataError> {
        Result.failure(DataError.requestError).publisher.eraseToAnyPublisher()
    }
}
