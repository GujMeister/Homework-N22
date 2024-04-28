import UIKit
import Foundation

class CountryTableViewCell: UITableViewCell {
    // MARK: - Properties
    lazy var countryFlagImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var countryNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Title"
        return label
    }()
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        contentView.layer.cornerRadius = contentView.bounds.height / 2
        contentView.layer.borderColor = UIColor.label.cgColor
        contentView.layer.borderWidth = 1
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "CountryTableViewCell")

        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        contentView.addSubview(countryFlagImageView)
        contentView.addSubview(countryNameLabel)
        contentView.addSubview(chevronImageView)
        
        countryFlagImageView.translatesAutoresizingMaskIntoConstraints = false
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countryFlagImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            countryFlagImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            countryFlagImageView.heightAnchor.constraint(equalToConstant: 20),
            countryFlagImageView.widthAnchor.constraint(equalToConstant: 30),
            
            countryNameLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -10),
            countryNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    
    // ამათი გატანა შემიძლია "CountryTableViewCellModel" მაგრამ აუცილებელია რომ import UIKit გავუკეთო მოდელში, იყოს აქ?
    func updateCell(with item: CountryTableViewCellModel) {
        setFlagImage(with: item.CountryflagUrl)
        countryNameLabel.text = item.CountryName
    }
    
    func setFlagImage(with url: URL?) {
        if let imageUrl = url {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.countryFlagImageView.image = UIImage(data: data)
                    }
                } else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        } else {
            countryFlagImageView.image = UIImage(named: "placeholderImage")
        }
    }
}
