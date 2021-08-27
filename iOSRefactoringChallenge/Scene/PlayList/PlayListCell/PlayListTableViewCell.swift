import UIKit
import Combine
class PlayListTableViewCell: TableViewCell {
    // MARK: - Properties
    private var viewModel: PlayListTableCellViewModelType!
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Configuration
     func configure(with viewModel: ReusableTableViewCellViewModelType) {
        guard let viewModel = viewModel as? PlayListTableCellViewModelType else { return }
        self.viewModel = viewModel
        bindViews()
    }
}
private extension PlayListTableViewCell {
    func bindViews() {
        if let label = textLabel {
        viewModel.trackTitle
            .assign(to: \.text, on: label)
            .store(in: &subscriptions)
        }
    }
}
