import Foundation
import UIKit

// აქაურობა დელეგატებით მაქ
// აქ UIKit-ის გარეშე არ მუშაობს ნახევარი კოდი, ერთი Keychain-შემიძლია ავამუშაო. Choose profile picture / Saving და ეგენი ვიუკონტროლეში უნდა მქონდეს? ხო გაასუქა?

protocol LoginViewModelDelegate: AnyObject {
    func didSelectProfilePicture(_ image: UIImage)
    func loginSuccessful()
    func loginFailed()
    func showPasswordMismatchAlert()
    func autoLoginSuccessful()
    func autoLoginFailed()
    func showMinimumCharacterLimitWarning()
}

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
    weak var viewController: LoginViewController?
    weak var ListVC: ListViewController?
    
    init(viewController: LoginViewController) {
        self.viewController = viewController
    }
    
    init(ListVC: ListViewController) {
        self.ListVC = ListVC
    }
    
    var completionHandler: ((URL?) -> Void)?
    var names = [String]()
    
    // MARK: - Keychain
        func login(withName name: String?, password: String?, completion: @escaping (Bool) -> Void) {
            guard let name = name, let password = password else {
                completion(false)
                return
            }
    
            if let storedPassword = getPasswordFromKeychain(for: name), storedPassword == password, name == name {
                UserDefaults.standard.set(false, forKey: "accountCreated")
                completion(true)
            } else {
                // Save new credentials to Keychain
                saveCredentialsToKeychain(name: name, password: password)
                UserDefaults.standard.set(true, forKey: "accountCreated")
                addNameToAllKeys(name)
                completion(true)
            }
        }
    
    private func addNameToAllKeys(_ name: String) {
        var allKeys: [String]
        if let allKeysData = UserDefaults.standard.data(forKey: "allKeys"),
           let storedKeys = try? JSONDecoder().decode([String].self, from: allKeysData) {
            allKeys = storedKeys
        } else {
            allKeys = []
        }
        
        allKeys.append(name)
        
        if let updatedKeysData = try? JSONEncoder().encode(allKeys) {
            UserDefaults.standard.set(updatedKeysData, forKey: "allKeys")
        }
    }

    private func getPasswordFromKeychain(for username: String) -> String? {
        guard let passwordData = KeychainService.load(key: username) else {
            return nil
        }
        return String(data: passwordData, encoding: .utf8)
    }
    
        private func saveCredentialsToKeychain(name: String, password: String) {
            KeychainService.save(key: name, data: password.data(using: .utf8)!)
            print("Credentials saved to Keychain for user: \(name)")
            print(KeychainService.load(key: name) as Any)
        }
    
    private func autoRetrieveCredentials() -> (String?, String?)? {
        guard let randomKey = getRandomKeyFromList(),
              let password = getPasswordFromKeychain(for: randomKey) else {
            return nil
        }
        return (randomKey, password)
    }
    
    // გამაწამა და ბოლოს ასეთი რამე მოვიფიქრე, account-ის დამატებისას სახელებს UserDefault-ებში ვაგდებ, და მერე ამ სახელით ვეძებ Keychain-ზე
    func getRandomKeyFromList() -> String? {
        guard let allKeysData = UserDefaults.standard.data(forKey: "allKeys"),
              let allKeys = try? JSONDecoder().decode([String].self, from: allKeysData) else {
            return nil
        }
        
        guard let randomIndex = (0..<allKeys.count).randomElement() else {
            return nil
        }
        
        return allKeys[randomIndex]
    }

    func getDataForKey(_ key: String) -> Data? {
        return KeychainService.load(key: key)
    }
    
    func autoLogin(completion: ((Bool) -> Void)? = nil) {
        guard let (username, password) = autoRetrieveCredentials() else {
            completion?(false)
            delegate?.autoLoginFailed()
            return
        }
        
        login(withName: username, password: password) { isLoggedIn in
            if isLoggedIn {
                print("Auto-login successful for user: \(String(describing: username))")
                self.delegate?.autoLoginSuccessful()
            } else {
                self.delegate?.autoLoginFailed()
            }
            completion?(isLoggedIn)
        }
    }
    
    // MARK: - Image Picker & Saver
    func chooseProfilePicture(completion: @escaping (UIImage?) -> Void) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = viewController
        imagePicker.allowsEditing = true
        self.viewController?.present(imagePicker, animated: true)
    }
    
    func saveImageToDocumentsDirectory(_ image: UIImage) -> URL? {
        guard let data = image.jpegData(compressionQuality: 1.0) ?? image.pngData() else {
            return nil
        }
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = "profile_picture.png"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        print(fileURL)
        
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving image: \(error.localizedDescription)")
            return nil
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            if saveImageToDocumentsDirectory(image) != nil {
                // vamcnobot delegate about the selected image
                delegate?.didSelectProfilePicture(image)
            } else {
                print("Failed to save image to Documents directory.")
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    // MARK: - Login Button Action
    func loginButtonAction(username: String?, password: String?, passwordCheck: String?) {
        guard let username = username, let password = password, let passwordCheck = passwordCheck else { return }
        
        guard username.count >= 4, password.count >= 4, passwordCheck.count >= 4 else {
            delegate?.showMinimumCharacterLimitWarning()
            return
        }
        
        if password == passwordCheck {
            login(withName: username, password: password) { isLoggedIn in
                if isLoggedIn {
                    self.delegate?.loginSuccessful()
                } else {
                    self.delegate?.loginFailed()
                }
            }
        } else {
            delegate?.showPasswordMismatchAlert()
        }
    }

    // MARK: - Create Label/Text Field & Misc
    func createLabelWith(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "FiraGo", size: 11)
        label.textAlignment = .left
        label.textColor = .label
        label.layer.cornerRadius = 25
        return label
    }
    
    func createTextfieldWith(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.layer.cornerRadius = 20.0
        tf.borderRect(forBounds: CGRect())
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: "909090"),
            .font: UIFont(name: "FiraGo", size: 11) ?? UIFont.systemFont(ofSize: 11)
        ]
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: tf.frame.height))
        tf.leftView = leftPaddingView
        tf.leftViewMode = .always
        
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        tf.backgroundColor = .systemFill
        tf.returnKeyType = .default
        tf.delegate = viewController.self
        tf.textColor = .label
        return tf
    }
    
    func showPasswordMismatchAlert(vm: UIViewController) {
        let alert = UIAlertController(title: "Password Mismatch", message: "The passwords entered do not match. Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vm.present(alert, animated: true, completion: nil)
    }
}

