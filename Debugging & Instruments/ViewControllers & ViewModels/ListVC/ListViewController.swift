import UIKit

class ListViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    var viewModel = ListVM()
    
    let searchController = UISearchController(searchResultsController: nil)
    
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryTableViewCell")
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reloadData()
        navigateToDetails()
        viewModel.didLoad()
        setupSearchController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.checkAccountStatus(displayWelcomeMessage: displayWelcomeMessage)
    }
    
    // MARK: - UI Setup
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(countriesLabel)
        view.addSubview(CountryListTableView)
        
        
        countriesLabel.translatesAutoresizingMaskIntoConstraints = false
        CountryListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            countriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            countriesLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            
            CountryListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            CountryListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            CountryListTableView.topAnchor.constraint(equalTo: countriesLabel.bottomAnchor, constant: 15),
            CountryListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    internal func reloadData() {
        viewModel.onCountryUpdated = { [weak self] in
            DispatchQueue.main.async {
                print("onCountryUpdated closure called. Reloading data...")
                self?.CountryListTableView.reloadData()
            }
        }
    }
    
    private func navigateToDetails() {
        viewModel.onCountrySelected = { [weak self] country in
            let countryDetailsViewModel = DetailsViewModel(country: country)
            let VC = DetailsViewController(viewModel: countryDetailsViewModel)
            self?.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func displayWelcomeMessage() {
        let alert = UIAlertController(title: "Welcome to the jungle", message: "Welcome to the jungle, we got fun and games, We got everything you want - honey - we know the names! We are the people that can find whatever you may need, If you got the money, honey, we got your disease, in the JUNGLE... WELCOME TO THE JUNGLEE!!!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Happy to be here!", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
