import UIKit
import Combine

protocol PlayListCoordinatorType: AnyObject {
  func goToDetailScreen(trackDetail: TrackDetailsType)
}

class PlayListCoordinator: Coordinator<Void> {
    private let window: UIWindow
    private var root: UINavigationController!
    private let result = PassthroughSubject<Void, CoordinatorError>()
    private var subscriptions = Set<AnyCancellable>()
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> AnyPublisher<Void, CoordinatorError> {
      root = UINavigationController(rootViewController: PlayListModuleFactory().make(coordinator: self))
        window.rootViewController = root
        window.makeKeyAndVisible()
        return result.eraseToAnyPublisher()
    }
}

extension PlayListCoordinator: PlayListCoordinatorType {
  func goToDetailScreen(trackDetail: TrackDetailsType) {
    let viewModel = PlayListDetailsViewModel(trackDetail: trackDetail)
    let controller = PlayListDetailsViewController(with: viewModel)

    root.pushViewController(controller, animated: true)
  }
}
