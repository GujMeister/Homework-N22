//
//  ViewController.swift
//  Debugging & Instruments
//
//  Created by Luka Gujejiani on 21.04.24.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    var listOfAllCountries: [CountriesModelElement]?
    
    private lazy var countriesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Countries"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryTableViewCell")
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchData()
        UISetup()
    }
    
    // MARK: - UI Setup
    func UISetup() {
        view.addSubview(countriesLabel)
        view.addSubview(tableView)
        
        countriesLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countriesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: countriesLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    // MARK: - Helper functions
    func fetchData() {
        getCountriesData { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.listOfAllCountries = data
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}

// MARK: - Data Source
extension ViewController: UITableViewDataSource {
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
    
    
}

// MARK: - Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight / 16
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
