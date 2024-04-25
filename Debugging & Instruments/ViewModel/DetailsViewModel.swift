import Foundation
import UIKit

class DetailsViewModel {
    var countryData: CountriesModelElement?
    
    var imageUrl: URL?
    var countryDescription: String
    var countryName: String
    var spellingName: String
    var capital: String
    var population: Int
    var region: String
    var neighborsString: String
    
    init(country: CountriesModelElement) {
        self.countryData = country
        self.countryDescription = country.flags?.alt ?? "No description available"
        self.countryName = country.name?.nativeName?.values.first?.official ?? "Name not available"
        self.spellingName = country.name?.official ?? "Spelling not available"
        self.capital = country.capital?.first ?? "Capital not available"
        self.population = country.population ?? 1000
        self.region = country.region?.rawValue ?? "Region not available"
        self.neighborsString = (country.borders ?? ["Neighbors not available"]).joined(separator: ", ")
        self.imageUrl = makeImageURL(imagecode: country.flags?.png ?? "")
    }
    
    func makeImageURL(imagecode: String) -> URL? {
        return URL(string: imagecode)
    }
    
    func loadImage(on view: DetailsViewController) {
        guard let imageUrl = imageUrl else {
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                view.flagImageView.image = image
            }
        }.resume()
    }
//    
//    func loadImage() {
//        guard let imageUrlString = chosenCountry?.flags?.png, let imageUrl = URL(string: imageUrlString) else {
//            return
//        }
//        
//        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
//            guard let data = data, let image = UIImage(data: data) else {
//                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            DispatchQueue.main.async {
//                self?.flagImageView.image = image
//            }
//        }.resume()
//    }
}
