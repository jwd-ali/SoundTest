import UIKit
protocol ConfigurableCell {
    func configure(with viewModel: ReusableTableViewCellViewModelType)
}
typealias TableViewCell =  UITableViewCell & ReusableView & ConfigurableCell

public protocol ReusableTableViewCellViewModelType {
    var reusableIdentifier: String { get }
}
