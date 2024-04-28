import Foundation
import UIKit

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerCell() {
        CountryListTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryTableViewCell")
    }
    
    // MARK: - Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countryTableViewCellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }

        let countryCellViewModel = viewModel.countryTableViewCellViewModel[indexPath.row]
        cell.updateCell(with: countryCellViewModel)
        cell.selectionStyle = .none
        
        return cell
    }
    
    // MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight / 14
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.navigateToCountryDetails(index: indexPath.row)
    }
}

