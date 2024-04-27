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
        
        let cellModel = viewModel.countryForTableViewCell.value?[indexPath.row]
        let interfaceStyle = traitCollection.userInterfaceStyle
        cellModel?.configureCell(cell: cell, interfaceStyle: interfaceStyle)
        cell.selectionStyle = .none

        return cell
    }
    
    // MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let countryName = CountryData[indexPath.row].countryName
        print(countryName, "📖")
        viewModel.openDetail(with: countryName)
    }
}
