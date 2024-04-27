import Foundation
import UIKit

class ListViewModel {
    
    var navigationController: UINavigationController?
    var isLoading: Observable<Bool> = Observable(false)
    var staticInfo: [CountriesModelElement]?
    var countryDataForTableView: Observable<[CountriesModelElement]> = Observable(nil)
    var countryForTableViewCell: Observable<[CountryTableViewCellModel]> = Observable([])
    var ListViewController: ListViewController!
    
    private(set) var filteredCountries: [CountriesModelElement]? = []
    
    // MARK: - Fetching Data
    func fetchData() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        getCountriesData { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                print("🟢")
                print("Name of the first country", data.first?.name?.common as Any)
                DispatchQueue.main.async {
                    self?.staticInfo = data
                    self?.mapTableViewData()
                    self?.mapCellData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    // MARK: - Mapping data into the Variables
    func mapTableViewData() {
        self.countryDataForTableView.value = self.staticInfo
        print("I'm in mapCellData", countryDataForTableView.value?.count as Any)
    }
    
    func mapCellData() {
        guard let staticInfo = staticInfo else {
            self.countryForTableViewCell.value = nil
            return
        }
        let cellModels = staticInfo.map { CountryTableViewCellModel(countriesModelElement: $0) }
        self.countryForTableViewCell.value = cellModels
    }
    
    // MARK: - Binding info
    func bindViewModel(_ viewController: ListViewController) {
        isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else {
                return
            }
            print("isLoading value changed to:", isLoading)
            DispatchQueue.main.async {
                if isLoading {
                    viewController.activityIndiactor.startAnimating()
                } else {
                    viewController.activityIndiactor.stopAnimating()
                }
            }
            self.countryForTableViewCell.bind { [weak self] countries in
                guard let _ = self, let countries = countries else {
                    return
                }
                viewController.CountryData = countries
                viewController.reloadTableView()
                print(viewController.CountryData.count, "⛔️")
            }
        }
    }
    
    // MARK: - Cell info
    func getCountry(with name: String) -> CountriesModelElement? {
        guard let country = countryDataForTableView.value?.first(where: { $0.name?.common == name }) else {
            return nil
        }
        return country
    }
    
    func openDetail(with countryName: String) {
        guard let chosenCountry = getCountry(with: countryName) else {
            return
        }
        let detailsViewModel = DetailsViewModel(country: chosenCountry)
        let detailsController = DetailsViewController(viewModel: detailsViewModel)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }
    
    func cellHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight / 14
    }
}

// MARK: - Search Bar Functions
extension ListViewModel {
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }

    public func updateSearchController(searchBarText: String?) {
        self.filteredCountries = staticInfo
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else {
                self.countryForTableViewCell.value = staticInfo?.map { CountryTableViewCellModel(countriesModelElement: $0) }
                return
            }
            self.filteredCountries = self.filteredCountries?.filter { country in
                guard let commonName = country.name?.common?.lowercased() else { return false }
                return commonName.contains(searchText)
            }
        }
        self.countryForTableViewCell.value = filteredCountries?.map { CountryTableViewCellModel(countriesModelElement: $0) }
    }
}
