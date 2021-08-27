import UIKit
import Combine

class PlayListViewController: UIViewController {
    // MARK: - Views
    private lazy var activityIndicator = ActivityView(style: .large)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Properties
    private let viewModel: PlayListViewModelType
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    init(viewModel: PlayListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupObservers()
    }
}

private extension PlayListViewController {
    
    func setupViews() {
        view.backgroundColor = .white
        tableView.register(PlayListTableViewCell.self, forCellReuseIdentifier: PlayListTableViewCell.reuseIdentifier)

        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView
            .pinToSuperView()
    }
    
    func setupObservers() {
        viewModel.refreshPlaylist.send()
        
        viewModel.navigationTitle
            .assign(to: \.title, on: navigationItem)
            .store(in: &subscriptions)
        
        viewModel.isLoading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isLoading in
                guard let self = self else {return}
                isLoading ? self.view.addSubview(self.activityIndicator) : self.activityIndicator.removeFromSuperview()
            })
            .store(in: &subscriptions)
        
        viewModel.cellViewModels
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &subscriptions)
        
        viewModel.error
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] errorMessage in
                self?.showAlert(message: errorMessage)
            })
            .store(in: &subscriptions)
    }
    
}
extension PlayListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: PlayListTableViewCell.reuseIdentifier, for: indexPath) as? PlayListTableViewCell
        else {
            return UITableViewCell()
            
        }
        cell.configure(with: viewModel.cellViewModels.value[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.value.count
    }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.selectIndex.send(indexPath)
  }
}
