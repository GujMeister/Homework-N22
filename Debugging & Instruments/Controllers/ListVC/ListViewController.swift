import UIKit

class ListViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    var viewModel = ListViewModel()
    var CountryData: [CountryTableViewCellModel] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    var activityIndiactor: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    private lazy var countriesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Countries"
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()

    lazy var CountryListTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.navigationController = navigationController
        setupTableView()
        UISetup()
        viewModel.bindViewModel(self)
        viewModel.ListViewController = self
        viewModel.fetchData()
        setupSearchController()
        NotificationCenter.default.addObserver(self, selector: #selector(traitCollectionDidChange(_:)), name: UIApplication.didChangeStatusBarFrameNotification, object: nil)
    }

    
    // MARK: - UI Setup
    func UISetup() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(activityIndiactor)
        view.addSubview(countriesLabel)
        view.addSubview(CountryListTableView)
        
        
        activityIndiactor.translatesAutoresizingMaskIntoConstraints = false
        countriesLabel.translatesAutoresizingMaskIntoConstraints = false
        CountryListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndiactor.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndiactor.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            countriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countriesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),

            CountryListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            CountryListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            CountryListTableView.topAnchor.constraint(equalTo: countriesLabel.bottomAnchor, constant: 40),
            CountryListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - Setup Search Bar & Results
extension ListViewController: UISearchResultsUpdating {
    
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Countries"
        
        self.searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
    
    // MARK: - Trait Collection Changes
    @objc override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else {
            return
        }
        CountryListTableView.reloadData()
    }
}
