import Foundation
import Combine
protocol PlayListRepositoryType {
    func getPlayList(with ID: String) -> AnyPublisher<[TrackType], DataError>
}

class RemotePlayListRepository: PlayListRepositoryType {
    private let service: PlayListServiceType
    private let mapper: TracksMappingType
    
    init(service: PlayListServiceType, mapper: TracksMappingType) {
        self.service = service
        self.mapper = mapper
    }
    
    func getPlayList(with ID: String) -> AnyPublisher<[TrackType], DataError> {
        getAllPlayList(with: ID)
            .tryMap { result in
                result.tracks.map { self.mapper.map($0) }
            }
            .mapError {_ in DataError.requestError}
            .eraseToAnyPublisher()
    }
    
    private func getAllPlayList(with ID: String) -> AnyPublisher<TracksResponse, DataError> {
        service.getPlayList(id: ID)
    }
}
