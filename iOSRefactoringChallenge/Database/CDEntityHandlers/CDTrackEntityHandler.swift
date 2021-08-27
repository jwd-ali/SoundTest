import Foundation
import CoreData
import Combine

protocol PersistentType {
    func add(tracks: [TrackType]) throws
    func getAllTracks() -> AnyPublisher<[TrackType], DataError>
}

class CDTrackEntityHandler: PersistentType {
    // MARK: Properties
    static var fetchRequest: NSFetchRequest<CDTrack> { return CDTrack.fetchRequest() }
    private let coreDataStack: CoreDataType
    
    // MARK:- Initialization
    init(persistentStack: CoreDataType  = CoreDataStack.shared) {
        self.coreDataStack = persistentStack
    }
    
    // MARK:- Add Track
    private func add(track: TrackType, context: NSManagedObjectContext) {
        let record = create(onContext: context)
        record.trackID = Int64(track.trackId)
        record.trackTitle = track.trackTitle
    }
    
    func add(tracks: [TrackType]) throws {
        let context = coreDataStack.workingContext
        tracks.forEach {[unowned self] in add(track: $0, context: context)  }
        try coreDataStack.saveWorkingContext(context)
    }
    
    func getAllTracks() -> AnyPublisher<[TrackType], DataError> {
        let fetchRequest = CDTrackEntityHandler.fetchRequest
        let context = coreDataStack.workingContext
        if let fetch = try? context.fetch(fetchRequest) {
            return  Just(fetch)
                .tryMap { allTracks in
                    allTracks.map{ Track(trackId: Int($0.trackID), trackTitle: $0.trackTitle) }
                }
                .mapError { _ in DataError.unknown }
                .eraseToAnyPublisher()
        } else {
            return Just([]).mapError{ _ in DataError.unknown }
                .eraseToAnyPublisher()
        }
    }
}
private extension CDTrackEntityHandler {
    func create(onContext context: NSManagedObjectContext) -> CDTrack {
        return CDTrack(entity: CDTrack.entity(), insertInto: context)
    }
    
}
