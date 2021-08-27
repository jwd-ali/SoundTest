import Foundation
import Combine
public enum CoordinatorError: Error {
    case unknown
}

open class Coordinator<T>: NSObject {
    
    typealias CoordinationResult = T
    public var disposeBag = [Cancellable]()
    
    let identifier = UUID()
    
    private var childCoordinators = [UUID: Any]()
    private func store<T>(coordinator: Coordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
        
    }
    
    private func free<T>(coordinator: Coordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    
    public override init () {}
    
    open func coordinate<T>(to coordinator: Coordinator<T>) -> AnyPublisher<T, CoordinatorError> {
        store(coordinator: coordinator)
        return coordinator.start().handleEvents(receiveOutput: { [weak self] _ in
                self?.free(coordinator: coordinator)
        }).eraseToAnyPublisher()
    }
    
    open func start() -> AnyPublisher<T, CoordinatorError> {
        fatalError("Start method should be implemented.")
    }
    
    open func freeAll() {
        childCoordinators = [UUID: Any]()
    }
}
