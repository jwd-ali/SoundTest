import UIKit
final class PlayListModuleFactory {
  func make(coordinator: PlayListCoordinatorType) -> UIViewController {
    makeAndExpose(coordinator: coordinator).view
    }
    
    typealias ModuleComponents = (
        view: UIViewController,
        viewModel: PlayListViewModelType
    )
    
    func makeAndExpose(coordinator: PlayListCoordinatorType) -> ModuleComponents {
        let service = PlayListService(apiClient: APIClient())
        let mapper = TrackMapper()
        
        let remoteRepository = RemotePlayListRepository(service: service, mapper: mapper)
        let localRepository = LocalPlayListRepository(persistentStore: CDTrackEntityHandler())
        let remoteWithLocal = RemoteWithLocalFallbackRepository(local: localRepository, remote: remoteRepository)
      let viewModel = PlayListViewModel(repository: remoteWithLocal, navigator: coordinator)
        let viewController = PlayListViewController(viewModel: viewModel)
        return (
            view: viewController,
            viewModel: viewModel
        )
    }
}
