import Foundation
import UIKit

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.CountryListTableView.dataSource = self
        self.CountryListTableView.delegate = self
        self.registerCell()
    }
    
    func registerCell() {
        CountryListTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryTableViewCell")
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.CountryListTableView.reloadData()
        }
    }
    
    // MARK: - Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CountryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        
//        let currentCountry = CountryData[indexPath.row]
//        cell.configureCell(with: currentCountry.name?.common ?? "Country Name Not Found",
//                           imageUrl: currentCountry.flags?.png)
        
        let cellModel = viewModel.countryForTableViewCell.value?[indexPath.row]
        cellModel?.configureCell(cell: cell)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    // MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let countries = CountryData
//        let countryToPassInDetailsView = countries[indexPath.row]
//        let detailsVC = CountryViewController()
//        detailsVC.chosenCountry = countryToPassInDetailsView
//        navigationController?.pushViewController(detailsVC, animated: true)
        
        let countryName = CountryData[indexPath.row].countryName
        print(countryName, "📖")
        self.openDetail(countryName: countryName)
        
    }
}
