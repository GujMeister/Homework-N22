import Foundation
import UIKit

class CountryTableViewCellModel {
    var countryName: String
    var imageUrl: URL?
    
    init(countriesModelElement: CountriesModelElement) {
        self.countryName = countriesModelElement.name?.common ?? "Name not found"
        self.imageUrl = makeImageURL(imagecode: countriesModelElement.flags?.png ?? "")
    }
    
    func makeImageURL(imagecode: String) -> URL? {
        return URL(string: imagecode)
    }
    
    func configureCell(cell: CountryTableViewCell) {
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
