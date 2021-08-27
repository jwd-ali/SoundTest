import Foundation
import CoreData

extension CDTrack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTrack> {
        return NSFetchRequest<CDTrack>(entityName: "CDTrack")
    }

    @NSManaged public var trackID: Int64
    @NSManaged public var trackTitle: String

}

extension CDTrack : Identifiable {

}
