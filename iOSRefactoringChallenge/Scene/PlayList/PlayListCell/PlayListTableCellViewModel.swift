import Foundation
import Combine
protocol PlayListTableCellViewModelType: ReusableTableViewCellViewModelType {
    var trackTitle: AnyPublisher<String?, Never> { get }
  var track: TrackType { get }
}

class PlatListTableCellViewModel: PlayListTableCellViewModelType {

    //MARK:- Properties
    var trackTitle: AnyPublisher<String?, Never> { trackTitleSubject.eraseToAnyPublisher() }
    var reusableIdentifier: String { PlayListTableViewCell.reuseIdentifier }

    //MARK:- Subjects
    private let trackTitleSubject: CurrentValueSubject<String?, Never>
    private var subscribers = Set<AnyCancellable>()
    let track: TrackType
    
  init(_ track: TrackType) {
    self.track = track
    trackTitleSubject = CurrentValueSubject(track.trackTitle)
  }
}
