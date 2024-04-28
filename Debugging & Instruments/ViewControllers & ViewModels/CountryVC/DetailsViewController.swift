import UIKit

class DetailsViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: DetailsViewModel!
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Scrollview
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        
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
        contentView.addSubview(bulliedView)
        
        flagImageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        aboutFlagLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutFlagDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        basicInformationLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        secondSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        linksLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        bulliedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flagImageViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            flagImageViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            flagImageViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            
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
            
            buttonsStackView.topAnchor.constraint(equalTo: linksLabel.bottomAnchor, constant: 15),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            
            bulliedView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor),
            bulliedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: 5),
            contentView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant: -5),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            contentView.heightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -10),
        ])
        
        return scrollView
    }()
    
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
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        
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
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "About the flag:"
        return label
    }()
    
    private lazy var aboutFlagDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Flag Description Label: Error loading"
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private lazy var basicInformationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Basic Information:"
        return label
    }()
    
    lazy var titleName = viewModel.createLabelWith(text: "Native name:", textAlignment: .left)
    lazy var titleSpelling = viewModel.createLabelWith(text: "Spelling:", textAlignment: .left)
    lazy var titleCapital = viewModel.createLabelWith(text: "Capital:", textAlignment: .left)
    lazy var titlePopulation = viewModel.createLabelWith(text: "Population:", textAlignment: .left)
    lazy var titleRegion = viewModel.createLabelWith(text: "Region:", textAlignment: .left)
    lazy var titleNeighbors = viewModel.createLabelWith(text: "Neighbors:", textAlignment: .left)
    
    lazy var infoName = viewModel.createLabel(textAlignment: .right)
    lazy var infoSpelling = viewModel.createLabel(textAlignment: .right)
    lazy var infoCapital = viewModel.createLabel(textAlignment: .right)
    lazy var infoPopulation = viewModel.createLabel(textAlignment: .right)
    lazy var infoRegion = viewModel.createLabel(textAlignment: .right)
    lazy var infoNeighbors = viewModel.createLabel(textAlignment: .right)
    
    lazy var TitleVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        
        stackView.addArrangedSubview(titleName)
        stackView.addArrangedSubview(titleSpelling)
        stackView.addArrangedSubview(titleCapital)
        stackView.addArrangedSubview(titlePopulation)
        stackView.addArrangedSubview(titleRegion)
        stackView.addArrangedSubview(titleNeighbors)
        
        return stackView
    }()
    
    lazy var infoVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        
        stackView.addArrangedSubview(infoName)
        stackView.addArrangedSubview(infoSpelling)
        stackView.addArrangedSubview(infoCapital)
        stackView.addArrangedSubview(infoPopulation)
        stackView.addArrangedSubview(infoRegion)
        stackView.addArrangedSubview(infoNeighbors)
        
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        stackView.addArrangedSubview(TitleVStack)
        stackView.addArrangedSubview(infoVStack)
        
        return stackView
    }()

    private let secondSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private let linksLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Useful links:"
        return label
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [googleMapsButton, bulliedView, streetMapsButton])
        bulliedView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var googleMapsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "GoogleMaps"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 50 / 2
        button.layer.borderWidth = 2
        button.layer.borderColor = viewModel.systemBorderColor()
        button.imageView?.contentMode = .scaleAspectFit
        
        /* ანუ კი ამბობს არ უნდა იმუშაოს ამანო მაგრამ 1. ალტერნატივა მართლა ვერ ვნახე, ფიდბექში რაც მომწერეთ ეგეც არ მუშაობდა და კიდე ბევრი სხვა ამიტომ არვიცი უბრალოდ რა ვუყო 2. მუშაობს
         
         მესამე ცდა: დაავიწყდათ ალბათ ისე გადართულები არიან SwiftUI-ზე */
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        button.addAction(UIAction(handler: { _ in
            self.viewModel.didTapGoogleMapsButton()
        }), for: .touchUpInside)
        
        return button
    }()
    
    lazy var streetMapsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "StreetMaps"), for: .normal)
        button.clipsToBounds = true
        button.imageView?.clipsToBounds = true
        button.layer.cornerRadius = 50 / 2
        button.layer.borderWidth = 2
        button.layer.borderColor = viewModel.systemBorderColor()
        button.imageView?.contentMode = .scaleAspectFit
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        button.addAction(UIAction(handler: { _ in
            self.viewModel.didTapOpenStreetMapsButton()
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
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Setup Config View
    func configView() {
        self.aboutFlagDescriptionLabel.text = viewModel.countryDescription
        self.infoName.text = viewModel.countryName
        self.infoSpelling.text = viewModel.countrySpellingName
        self.infoRegion.text = viewModel.countryRegion
        self.infoCapital.text = viewModel.countryCapital
        self.infoNeighbors.text = viewModel.countryNeighborsString
        self.infoPopulation.text = String(viewModel.countryPopulation)
        viewModel.loadImage(on: self)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        title = viewModel.countryName
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
}
