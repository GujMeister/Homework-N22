import Foundation
import UIKit

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.CountryListTableView.dataSource = self
        self.CountryListTableView.delegate = self
    }
    
    
    // MARK: - Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = listOfAllCountries?.count {
            return data
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        
        if let currentCountry = listOfAllCountries?[indexPath.row] {
            cell.configureCell(with: currentCountry.name?.common ?? "Country Name Not Found",
                               imageUrl: currentCountry.flags?.png)
        }
        
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    // MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight / 15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let countries = listOfAllCountries {
            let countryToPassInDetailsView = countries[indexPath.row]
            let detailsVC = CountryViewController()
            detailsVC.chosenCountry = countryToPassInDetailsView
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

