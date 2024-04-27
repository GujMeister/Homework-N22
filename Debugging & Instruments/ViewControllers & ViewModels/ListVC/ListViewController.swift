import UIKit

class ListViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    var viewModel = ListViewModel()
    var CountryData: [CountryTableViewCellModel] = []
    private let searchController = UISearchController(searchResultsController: nil)
        
    lazy var countriesLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Countries"
        return label
    }()

    lazy var CountryListTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        viewModelSetup()
        setupSearchController()
        setupNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let accountCreated = UserDefaults.standard.bool(forKey: "accountCreated")
        if accountCreated {
            viewModel.displayWelcomeMessage()
        } else {
            print("Account is not created")
        }
    }

    func viewModelSetup() {
        viewModel.navigationController = navigationController
        viewModel.bindViewModel(self)
        viewModel.ListViewController = self
        viewModel.fetchData()
    }
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(traitCollectionDidChange(_:)), name: UIApplication.didChangeStatusBarFrameNotification, object: nil)
        /*
         ეს რითიც მეუბნება გააკეთეო ეგ იყო depriciated iOS 17-ში და მერე ის რითიც მეუბნება გააკეთეო ეგ უკვე ვერც მე ვერ გავიგე და ვერც ჩატმა
         მთავარია მუშაობს?!
         */
    }
    
    
    // MARK: - UI Setup
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(countriesLabel)
        view.addSubview(CountryListTableView)
        
        
        countriesLabel.translatesAutoresizingMaskIntoConstraints = false
        CountryListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            countriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countriesLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            
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
