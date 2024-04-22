import UIKit

class CountryViewController: UIViewController {
    //MARK: - Scrollview
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        contentView.addSubview(flagImageViewContainer)
        contentView.addSubview(aboutFlagLabel)
        contentView.addSubview(aboutFlagDescriptionLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(basicInformationLabel)
        contentView.addSubview(infoStackView)
        contentView.addSubview(secondSeparatorView)
        contentView.addSubview(linksLabel)
        contentView.addSubview(buttonsStackView)
        
        flagImageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        aboutFlagLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutFlagDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        basicInformationLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        secondSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        linksLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flagImageViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            flagImageViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            flagImageViewContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            flagImageViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            
            aboutFlagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            aboutFlagLabel.topAnchor.constraint(equalTo: flagImageViewContainer.bottomAnchor, constant: 15),
            
            aboutFlagDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            aboutFlagDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            aboutFlagDescriptionLabel.topAnchor.constraint(equalTo: aboutFlagLabel.bottomAnchor, constant: 20),
            
            separatorView.topAnchor.constraint(equalTo: aboutFlagDescriptionLabel.bottomAnchor, constant: 20),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            
            basicInformationLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 24),
            basicInformationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            infoStackView.topAnchor.constraint(equalTo: basicInformationLabel.bottomAnchor, constant: 15),
            
            
            secondSeparatorView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 20),
            secondSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            secondSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            secondSeparatorView.heightAnchor.constraint(equalToConstant: 2),
            
            linksLabel.topAnchor.constraint(equalTo: secondSeparatorView.bottomAnchor, constant: 24),
            linksLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 94),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -94),
            buttonsStackView.topAnchor.constraint(equalTo: linksLabel.bottomAnchor, constant: 15),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        return scrollView
    }()
    
    // MARK: - Properties
    var chosenCountry: CountriesModelElement?
//    let buttonSize: CGFloat = 50
    
    lazy var flagImageViewContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.cornerRadius = 21
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return view
    }()

    lazy var flagImageView: UIImageView = {
        return flagImageViewContainer.subviews.first as! UIImageView
    }()
    
    private lazy var aboutFlagLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "About the flag:"
        return label
    }()
    
    private lazy var aboutFlagDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = chosenCountry?.flags?.alt
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private lazy var basicInformationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Basic Information:"
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        let leftLabels = ["Native name:", "Spelling:", "Capital:", "Population:", "Region:", "Neighbors:"]
        
        let nativeName = chosenCountry?.name?.nativeName?.values.first?.official ?? "Name not available"
        let spellingName = chosenCountry?.name?.official ?? "Spelling not available"
        let capital = chosenCountry?.capital?.first ?? "Capital not available"
        let population = String(chosenCountry?.population ?? 1000)
        let region = chosenCountry?.region?.rawValue ?? "Region not available"
        let neighborsString = (chosenCountry?.borders ?? ["Neighbors not available"]).joined(separator: ", ")
        
        let rightLabels = ["\(nativeName)",
                           "\(spellingName)",
                           "\(capital)",
                           "\(population)",
                           "\(region)",
                           "\(neighborsString)"]
        
        let leftStackView = createVerticalStackView(with: leftLabels, textAlignment: .left)
        let rightStackView = createVerticalStackView(with: rightLabels, textAlignment: .right)
        
        stackView.addArrangedSubview(leftStackView)
        stackView.addArrangedSubview(rightStackView)
        
        return stackView
    }()
    
    private let secondSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private let linksLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Useful links:"
        return label
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [googleMapsButton, bulliedView, streetMapsButton])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var googleMapsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "GoogleMaps"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 50 / 2 // Make it circular
        button.layer.borderWidth = 2 // Border width
        button.layer.borderColor = UIColor.black.cgColor // Border color
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        // Set image aspect fit to make it square
        button.imageView?.contentMode = .scaleAspectFit
        
        button.addAction(UIAction(handler: { _ in
            self.didTapGoogleMapsButton()
        }), for: .touchUpInside)
        
        return button
    }()
    
    lazy var streetMapsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "StreetMaps"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 50 / 2 // Make it circular
        button.layer.borderWidth = 2 // Border width
        button.layer.borderColor = UIColor.black.cgColor // Border color
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        button.imageView?.contentMode = .scaleAspectFit
        
        button.addAction(UIAction(handler: { _ in
            self.didTapOpenStreetMapsButton()
        }), for: .touchUpInside)
        
        return button
    }()
    
    lazy var bulliedView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        title = chosenCountry?.name?.official ?? "Country"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                ])
    }
    
    // MARK: - Button Actions
    
    func didTapGoogleMapsButton() {
        if let googleMapsURLString = chosenCountry?.maps?.googleMaps, let googleMapsURL = URL(string: googleMapsURLString) {
            UIApplication.shared.open(googleMapsURL)
        }
    }
    
    func didTapOpenStreetMapsButton() {
        if let openStreetMapsURLString = chosenCountry?.maps?.openStreetMaps, let openStreetMapsURL = URL(string: openStreetMapsURLString) {
            UIApplication.shared.open(openStreetMapsURL)
        }
    }
    
    // MARK: - Helper Functions
    private func createVerticalStackView(with labels: [String], textAlignment: NSTextAlignment) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        
        for labelText in labels {
            let label = UILabel()
            label.textColor = .black
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.text = labelText
            label.textAlignment = textAlignment
            label.numberOfLines = 0
            stackView.addArrangedSubview(label)
        }
        
        return stackView
    }
    
    func loadImage() {
        guard let imageUrlString = chosenCountry?.flags?.png, let imageUrl = URL(string: imageUrlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                self?.flagImageView.image = image
            }
        }.resume()
    }
}

#Preview {
    CountryViewController()
}
