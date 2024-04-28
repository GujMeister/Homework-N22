import Foundation

struct CountryTableViewCellModel {
    // MARK: - Properties
    private var country: CountriesModelElement
    
    init(country: CountriesModelElement) {
        self.country = country
    }
    
    var CountryflagUrl: URL? {
        URL(string: country.flags?.png ?? "")
    }
    
    var CountryName: String? {
        country.name?.common
    }
}

