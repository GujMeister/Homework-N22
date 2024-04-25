import Foundation
import UIKit

class ListViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    
    var staticInfo: [CountriesModelElement]?
    
    var countryDataForTableView: Observable<[CountriesModelElement]> = Observable(nil)
    
    var countryForTableViewCell: Observable<[CountryTableViewCellModel]> = Observable([])
    
    var ListViewController: ListViewController!
    
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
                print(data.first as Any)
                DispatchQueue.main.async {
                    self?.staticInfo = data
                    self?.mapCellData()
                    self?.mapCellData2()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func mapCellData() {
        self.countryDataForTableView.value = self.staticInfo
        print("I'm in mapCellData", countryDataForTableView.value?.count as Any)
    }
    
    func mapCellData2() {
        guard let staticInfo = staticInfo else {
            self.countryForTableViewCell.value = nil
            return
        }
        let cellModels = staticInfo.map { CountryTableViewCellModel(countriesModelElement: $0) }
        self.countryForTableViewCell.value = cellModels
    }
    
    
    
    func cellHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight / 15
    }
    
//    // aq viewModel.countrydata an ertia an meore arvici gaarkvie
//    func openDetail(countryName: String) {
//        guard let country = viewModel.countryDataForTableView.
//    }

    func getCountry(with name: String) -> CountriesModelElement? {
//        guard let country = countryDataForTableView.value?.first(where: { $0.name?.nativeName?.values.first?.official == name }) else {
//            return nil
//        }
//        return country
        
        guard let country = countryDataForTableView.value?.first(where: { $0.name?.common == name }) else {
            return nil
        }
        return country
    }


}
