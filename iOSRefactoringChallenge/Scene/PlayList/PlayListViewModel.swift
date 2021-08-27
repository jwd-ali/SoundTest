import Foundation
import Combine

protocol PlayListViewModelType {
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var refreshPlaylist: PassthroughSubject<Void, DataError> { get  }
    var cellViewModels: CurrentValueSubject<[PlayListTableCellViewModelType], Never> { get }
    var error: AnyPublisher<String, Never> { get }
    var navigationTitle: AnyPublisher<String?, Never> { get }
    var selectIndex:PassthroughSubject<IndexPath, Never> {  get}
}

class PlayListViewModel: PlayListViewModelType {

    var refreshPlaylist = PassthroughSubject<Void, DataError>()
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var error: AnyPublisher<String, Never> { errorSubject.eraseToAnyPublisher()  }
    var cellViewModels = CurrentValueSubject<[PlayListTableCellViewModelType], Never>([])
    var navigationTitle: AnyPublisher<String?, Never> { navigationTitleSubject.eraseToAnyPublisher() }
    var selectIndex = PassthroughSubject<IndexPath, Never>()

    
    private let navigationTitleSubject = CurrentValueSubject<String?, Never>("PlayList")
    private let errorSubject = PassthroughSubject<String, Never>()

    //Diffable datasource
    private let tracksSubject = PassthroughSubject<[TrackType], DataError>()
    private weak var coordinator: PlayListCoordinatorType?
    private var allTracks = [Track]()


    private let repository: PlayListRepositoryType
    private var subscriptions = Set<AnyCancellable>()
    private let playlistID = "79670980"

  init(repository: PlayListRepositoryType, navigator: PlayListCoordinatorType) {
        self.repository = repository
        self.coordinator = navigator
        configureCellViewModels()
    }
}

private extension PlayListViewModel {

    private func configureCellViewModels() {
        refreshPlaylist
            .flatMap { [unowned self] _ in
                self.getPlayList(id: playlistID)
            }.map { tracks in
                self.allTracks = tracks 
                tracks.map { PlatListTableCellViewModel($0) }
            }
            .sink(receiveCompletion: {[weak self] result in
                self?.isLoading.send(false)

                switch result {
                case .failure(let error):
                    self?.errorSubject.send(error.localizedDescription)
                default:
                    break
                }
            }, receiveValue: { [unowned self] items in
                self.cellViewModels.send(items)
                self.isLoading.send(false)
            })
            .store(in: &subscriptions)
    }

    private func getPlayList(id: String) -> AnyPublisher<[TrackType], DataError> {
        isLoading.send(true)
        cellViewModels.send([])
        return repository.getPlayList(with: id)
    }

  private func indexSlected() {
    selectIndex.combineLatest(cellViewModels).map { index, models in models[index.row].track  }
      .sink{[weak self] in
        Log.d($0)
        //self?.goToDeatils(track: )
      }.store(in: &subscriptions)
  }

  private func goToDeatils(track: TrackDetailsType) {
    coordinator?.goToDetailScreen(trackDetail: track)
  }

}
