
import Foundation

class ListVM {
    // MARK: - Properties
    var CountriesFullInfo: [CountriesModelElement] = [] {
        didSet { onCountryUpdated?() }
    }
    
    var countryTableViewCellViewModel: [CountryTableViewCellModel] = [] {
        didSet { onCountryUpdated?() }
    }
    
    var onCountryUpdated: (() -> Void)?
    var onCountrySelected: ((CountriesModelElement) -> Void)?
    
    // MARK: - Lifecycle
    func didLoad() {
        getCountries()
    }
    
    // MARK: - Child Method
    func getCountries() {
        getData()
    }
    
    // MARK: - Requests
    private func getData() {
        getCountriesData { [weak self] result in
            switch result {
            case .success(let data):
                print(data.count, "-Currently we have this many countries")
                DispatchQueue.main.async {
                    self?.CountriesFullInfo = data
                    self?.countryTableViewCellViewModel = data.map{CountryTableViewCellModel(country: $0 )}
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    // MARK: - Navigation
    func navigateToCountryDetails(index: Int) {
        self.onCountrySelected?(CountriesFullInfo[index])
    }
    
    // MARK: - Search Bar Function
    public func updateSearchController(searchBarText: String?) {
        guard let searchText = searchBarText?.lowercased(), !searchText.isEmpty else {
            countryTableViewCellViewModel = CountriesFullInfo.map { CountryTableViewCellModel(country: $0) }
            return
        }
        
        countryTableViewCellViewModel = CountriesFullInfo
            .filter({ (country: CountriesModelElement) -> Bool in
                return (country.name?.common ?? "").lowercased().contains(searchText)
            })
            .map { CountryTableViewCellModel(country: $0) }
    }
    
    // MARK: - Welcome Message
    func checkAccountStatus(displayWelcomeMessage: () -> Void) {
        let accountCreated = UserDefaults.standard.bool(forKey: "accountCreated")
        if accountCreated {
            displayWelcomeMessage()
        } else {
            print("Account is not created")
        }
    }
}
