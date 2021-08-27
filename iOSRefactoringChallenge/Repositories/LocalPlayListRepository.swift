import Foundation
import Combine

protocol PlayListSavableRepositoryType: PlayListRepositoryType {
    func saveTracks(tracks: [TrackType]) throws
}

class LocalPlayListRepository: PlayListSavableRepositoryType {
    private let store: PersistentType
    
    init(persistentStore: PersistentType) {
        store = persistentStore
    }
    
    func getPlayList(with ID: String) -> AnyPublisher<[TrackType], DataError> {
        store.getAllTracks()
    }
    
    func saveTracks(tracks: [TrackType]) throws {
        try store.add(tracks: tracks)
    }
}
