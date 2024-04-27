import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
//        let navigatioController = UINavigationController(rootViewController: ListViewController())
        let navigatioController = UINavigationController(rootViewController: LoginViewController())
        
        window?.rootViewController = navigatioController
        window?.makeKeyAndVisible()
    }
}
