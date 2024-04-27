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
    var googleLink: String
    var openStreetMapLink: String
    
    init(country: CountriesModelElement) {
        self.countryData = country
        self.countryDescription = country.flags?.alt ?? "No description available"
        self.countryName = country.name?.nativeName?.values.first?.official ?? "Name not available"
        self.spellingName = country.name?.official ?? "Spelling not available"
        self.capital = country.capital?.first ?? "Capital not available"
        self.population = country.population ?? 1000
        self.region = country.region?.rawValue ?? "Region not available"
        self.neighborsString = (country.borders ?? ["Neighbors not available"]).joined(separator: ", ")
        self.googleLink = country.maps?.googleMaps ?? "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
        self.openStreetMapLink = country.maps?.openStreetMaps ?? "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
        self.imageUrl = makeImageURL(imagecode: country.flags?.png ?? "")
    }
    
    // MARK: - Image Loader
    func makeImageURL(imagecode: String) -> URL? {
        return URL(string: imagecode)
    }
    
    func loadImage(on view: DetailsViewController) {
        guard let imageUrl = imageUrl else {
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            guard let data = data, let _ = self, let image = UIImage(data: data) else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                view.flagImageView.image = image
            }
        }.resume()
    }
    
    // MARK: - Button Border Colors
    func isIOS13OrLater() -> Bool {
        if #available(iOS 13.0, *) {
            return true
        } else {
            return false
        }
    }
    
    func systemBorderColor() -> CGColor {
        if isIOS13OrLater() {
            return UIColor.systemGray.cgColor
        } else {
            return UIColor.black.cgColor
        }
    }
    
    // MARK: - Button Actions
    func didTapGoogleMapsButton(country: CountriesModelElement?) {
        if let googleMapsURLString = country?.maps?.googleMaps, let googleMapsURL = URL(string: googleMapsURLString) {
            UIApplication.shared.open(googleMapsURL)
        }
    }

    func didTapOpenStreetMapsButton(country: CountriesModelElement?) {
        if let openStreetMapsURLString = country?.maps?.openStreetMaps, let openStreetMapsURL = URL(string: openStreetMapsURLString) {
            UIApplication.shared.open(openStreetMapsURL)
        }
    }
    
    // MARK: - Create Label Functions
    func createLabel(textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = textAlignment
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        return label
    }
    
    func createLabelWith(text: String, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.textColor = .label
        label.text = text
        label.textAlignment = textAlignment
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        return label
    }
}
