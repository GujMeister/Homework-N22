import Foundation
import UIKit

class LoginViewModel {
    
    weak var viewController: LoginViewController?

    init(viewController: LoginViewController) {
        self.viewController = viewController
    }
    
    var completionHandler: ((UIImage?) -> Void)?

    // MARK: - Image Picker
    func chooseProfilePicture() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = viewController.self
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
        picker.dismiss(animated: true) {
            if let image = info[.editedImage] as? UIImage {
                let _ = self.saveImageToDocumentsDirectory(image)
                DispatchQueue.main.async {
                    self.completionHandler?(image)
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

// MARK: - Create Label/Text Field
    
    func createLabelWith(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .left
        label.textColor = UIColor(hexFromString: "505050", alpha: 1)
        return label
    }
    
    func createTextfieldWith(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hexFromString: "909090"),
            .font: UIFont.systemFont(ofSize: 11) // Change to the desired font
        ]
        
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        tf.backgroundColor = UIColor(hexFromString: "EFEFEF")
        return tf
    }
    
    
    
    
    
    
    
    
    
    
    
}
extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[.editedImage] as? UIImage {
            addProfilePicture.setImage(image, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}






extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

#Preview {
    LoginViewController()
}
