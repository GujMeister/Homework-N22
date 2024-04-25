import Foundation
import UIKit

class CountryTableViewCellModel {
    var countryName: String
    var imageUrl: URL?
    
    init(countriesModelElement: CountriesModelElement) {
        self.countryName = countriesModelElement.name?.common ?? "Name not found"
        self.imageUrl = makeImageURL(imagecode: countriesModelElement.flags?.png ?? "")
    }
    
    // MARK: - ImageString to URL
    func makeImageURL(imagecode: String) -> URL? {
        return URL(string: imagecode)
    }
    
    // MARK: - Cell background color (Changable per system color)
    private func backgroundColor(forUserInterfaceStyle style: UIUserInterfaceStyle, cell: CountryTableViewCell) -> UIColor {
        switch style {
        case .dark:
            cell.countryNameLabel.textColor = .white
            return .systemGray6
        default:
            cell.countryNameLabel.textColor = .black
            return .white
        }
    }
    
    // MARK: - Configure cell porperties
    func configureCell(cell: CountryTableViewCell, interfaceStyle: UIUserInterfaceStyle) {
        cell.backgroundColor = backgroundColor(forUserInterfaceStyle: interfaceStyle, cell: cell)
        
        cell.countryNameLabel.text = countryName
        
        if let imageUrl = imageUrl {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.countryFlagImageView.image = UIImage(data: data)
                    }
                } else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        } else {
            cell.countryFlagImageView.image = UIImage(named: "placeholderImage")
        }
    }
}
