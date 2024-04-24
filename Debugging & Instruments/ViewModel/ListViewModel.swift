import Foundation
import UIKit

class ListViewModel {
    
    var listOfAllCountries: [CountriesModelElement]?
    
    var ListViewController: ListViewController!
    
    func numberOfRows() -> Int {
        return listOfAllCountries?.count ?? 0
    }

}
