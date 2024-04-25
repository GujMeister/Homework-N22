import UIKit

class ListViewController: UIViewController {
    // MARK: - Properties
    //ViewModel
    var viewModel = ListViewModel()
//    var CountryData: [CountriesModelElement] = [] (2)
    var CountryData: [CountryTableViewCellModel] = []
    
    var activityIndiactor: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    private lazy var countriesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Countries"
        return label
    }()
    
    lazy var CountryListTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configView()
        UISetup()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchData()
        setupTableView()
        bindViewModel()
    }
    
    // MARK: - UI Setup
    func UISetup() {
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
            CountryListTableView.topAnchor.constraint(equalTo: countriesLabel.bottomAnchor, constant: 20),
            CountryListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func configView() {
        setupTableView()
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndiactor.startAnimating()
                } else {
                    self.activityIndiactor.stopAnimating()
                }
            }
//            viewModel.countryDataForTableView.bind { [weak self] countries in (1)
//                guard let self = self, let countries = countries else {
//                    return
//                }
//                self.CountryData = countries
//                self.reloadTableView()
//                print(CountryData.count, "⛔️")
//            }
            
            viewModel.countryForTableViewCell.bind { [weak self] countries in
                guard let self = self, let countries = countries else {
                    return
                }
                self.CountryData = countries
                self.reloadTableView()
                print(CountryData.count, "⛔️")
            }
        }
    }
    // aq viewModel.countrydata an ertia an meore arvici gaarkvie
    func openDetail(countryName: String) {
        guard let chosenCountry = viewModel.getCountry(with: countryName) else {
            return
        }
        let detailsViewModel = DetailsViewModel(country: chosenCountry)
        let detailsController = DetailsViewController(viewModel: detailsViewModel)
        DispatchQueue.main.async {
        self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }

}
