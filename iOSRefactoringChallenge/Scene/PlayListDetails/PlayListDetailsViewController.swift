
import UIKit
import Combine
class PlayListDetailsViewController: UIViewController {

  // MARK: Views

  private lazy var nameLabel: UILabel = {
    let view = UILabel()
    return view
  }()

  private lazy var genreLabel: UILabel = {
    let view = UILabel()
    return view
  }()

  private lazy var titleLabel: UILabel = {
    let view = UILabel()
    return view
  }()

  private lazy var imageView: UIImageView = {
    let view = UIImageView()
    return view
  }()

  private lazy var stackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .leading
    return stack
  }()

// MARK: properties
  private var subscriptions = Set<AnyCancellable>()
  private let viewModel: PlayListDetailsViewModelType

  init(with viewModel: PlayListDetailsViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)

    setupView()
    setupConstraints()
    setupAssigning()

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension PlayListDetailsViewController {
  func setupView() {
    view.addSubview(stackView)
    [nameLabel, genreLabel, titleLabel, imageView].forEach(stackView.addArrangedSubview)
  }

  func setupConstraints() {
    stackView
      .pinToSuperView()
  }

  func setupAssigning() {
    viewModel.artistName.sink { [weak self]  (name) in
      self?.nameLabel.text = name
    }.store(in: &subscriptions)
  }

}
