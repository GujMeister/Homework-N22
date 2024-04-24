import UIKit

class ListViewController: UIViewController {
    // MARK: - Properties
    //    var listOfAllCountries: [CountriesModelElement]? //aq amis update ginda ro gamoitanos info imitoro yvela tableView func amas uyurebs sadly
    
    var listOfAllCountries: [CountriesModelElement]?

    //ViewModel
    var viewModel = ListViewModel()
    
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
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryTableViewCell")
        tableView.separatorStyle = .none
        //        tableView.dataSource = self
        //        tableView.delegate = self
        //        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configView()
        UISetup()
        fetchData()
    }
    
    // MARK: - UI Setup
    func UISetup() {
        view.addSubview(countriesLabel)
        view.addSubview(CountryListTableView)
        
        countriesLabel.translatesAutoresizingMaskIntoConstraints = false
        CountryListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
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
    
    func fetchData() {
        getCountriesData { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.listOfAllCountries = data
                    self.CountryListTableView.reloadData()
                    print(data)
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}
