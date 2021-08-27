import Foundation
import Combine
class RemoteWithLocalFallbackRepository: PlayListRepositoryType {
    
    private let remoteRepository: PlayListRepositoryType
    private let localRepository: PlayListSavableRepositoryType
    
    init(local: PlayListSavableRepositoryType, remote: PlayListRepositoryType) {
        remoteRepository = remote
        localRepository = local
    }
    
    func getPlayList(with ID: String) -> AnyPublisher<[TrackType], DataError> {
        remoteRepository
            .getPlayList(with: ID)
            .tryMap { [unowned self] in
                do {
                    try self.localRepository.saveTracks(tracks: $0)
                } catch {
                    throw DataError.unknown
                }
                return $0 }
            .tryCatch { [unowned self] _ in
                (self.localRepository.getPlayList(with: ID).eraseToAnyPublisher())
            }
            .mapError {_ in DataError.unknown }
            .eraseToAnyPublisher()
    }
}
