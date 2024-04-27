import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel: LoginViewModel!
    let listViewController = ListViewController()
    
    lazy var addProfilePicture: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "AddPerson"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 90
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 2
        button.imageView?.contentMode = .scaleToFill

        button.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.chooseProfilePicture { self.addProfilePicture.setImage($0, for: .normal) }
        }), for: .touchUpInside)
        
        return button
    }()
    
    let dummyView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var nameLabel = viewModel.createLabelWith(text: "მომხმარებლის სახელი")
    lazy var nameTextField = viewModel.createTextfieldWith(placeholder: "შეიყვანეთ მომხმარებლის სახელი")
    lazy var passwordLabel = viewModel.createLabelWith(text: "პაროლი")
    lazy var passwordTextField = viewModel.createTextfieldWith(placeholder: "შეიყვანეთ პაროლი")
    lazy var passwordCheckLabel = viewModel.createLabelWith(text: "გაიმეორეთ პაროლი")
    lazy var passwordCheckTextField = viewModel.createTextfieldWith(placeholder: "განმეორებით შეიყვანეთ პაროლი")
    
    lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField, dummyView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField, dummyView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var repeatPasswordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordCheckLabel, passwordCheckTextField, dummyView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var loginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameStackView, passwordStackView, repeatPasswordStackView])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("შესვლა", for: .normal)
        button.backgroundColor = UIColor(hexFromString: "3888FF")
        button.layer.cornerRadius = 10
        button.addAction(UIAction(handler: { [weak self] _ in
            if let self = self {
                viewModel.loginButtonAction(username: nameTextField.text, password: passwordTextField.text, passwordCheck: passwordCheckTextField.text)}
        }), for: .touchUpInside)
        return button
    }()
    
    var bulliedView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(viewController: self)
        setupUI()
        self.hideKeyboardWhenTappedAround()
        viewModel.delegate = self
        viewModel.autoLogin()
    }
    
    // MARK: - Lifecycle
    func setupUI() {
        view.backgroundColor = .tertiarySystemGroupedBackground
        
        self.nameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordCheckTextField.delegate = self
        
        
        view.addSubview(addProfilePicture)
        view.addSubview(loginStackView)
        view.addSubview(loginButton)
        view.addSubview(bulliedView)
        
        addProfilePicture.translatesAutoresizingMaskIntoConstraints = false
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        bulliedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addProfilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addProfilePicture.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            addProfilePicture.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.46),
            addProfilePicture.heightAnchor.constraint(equalTo: addProfilePicture.widthAnchor),
            
            loginStackView.topAnchor.constraint(equalTo: addProfilePicture.bottomAnchor, constant: 40),
            loginStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            loginStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 0),
            loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.055),
            
            bulliedView.topAnchor.constraint(equalTo: loginButton.bottomAnchor),
            bulliedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Delegate
extension LoginViewController: LoginViewModelDelegate {
    func loginSuccessful() {
        navigationController?.pushViewController(ListViewController(), animated: true)
        print("Login successful!")
    }
    
    func loginFailed() {
        print("Login failed!")
    }
    
    func showPasswordMismatchAlert() {
        let alert = UIAlertController(title: "Password Mismatch", message: "The passwords entered do not match. Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func autoLoginSuccessful() {
        let listViewController = ListViewController()
        navigationController?.pushViewController(listViewController, animated: true)
        print("Auto-login successful!")
    }
    
    func autoLoginFailed() {
        print("Auto-login failed!")
    }
    
    func didSelectProfilePicture(_ image: UIImage) {
        addProfilePicture.setImage(image, for: .normal)
    }
}
