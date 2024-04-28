import Foundation
import UIKit

// MARK: - Setup Search Bar & Results
extension ListViewController: UISearchResultsUpdating {

    func setupSearchController() {
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
}
