import Foundation
import CoreData

public protocol CoreDataType {
    var workingContext: NSManagedObjectContext { get }
    var managedObjectContext: NSManagedObjectContext { get }
    func saveContext()
    func saveWorkingContext(_ context: NSManagedObjectContext) throws
}

public class CoreDataStack: CoreDataType {
    /// Creation of Shared instance
  public static let shared = CoreDataStack()
    
    private init () {}
    
    /// managed object context, will be working as parent context on main queue
    public var managedObjectContext: NSManagedObjectContext {
        get {
            return persistentContainer.viewContext
        }
    }
    
    /// working managed object context, will be working as child context on private queue
    public var workingContext: NSManagedObjectContext {
        get {
            let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            context.parent = managedObjectContext
            return context
        }
    }
    
    /// persistent container
    private lazy var persistentContainer: NSPersistentContainer = {
        /// data model url
        let container = NSPersistentContainer(name: "iOSRefactoringChallenge")
        
        /// managed object model
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        })
        
        return container
    }()
    
}

//MARK:- Core Data Saving
extension CoreDataStack {
    /// saving main context once working cotext has been saved
     public func saveContext() {
        guard managedObjectContext.hasChanges  else { return }
        
        managedObjectContext.perform {
            do {
                try self.managedObjectContext.save()
            }
            catch {
                Log.e("Error while saving main context: \(error)")
            }
        }
    }
    
    /// saving working context
    public func saveWorkingContext(_ context: NSManagedObjectContext) throws {
        guard context.hasChanges  else { return }
            try context.save()
            saveContext()
    }
}
