import UIKit
import Foundation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
       
        let loginFactory = MyLoginFactory()
               
      //фабрику для создания LoginInspector
       let loginInspector = loginFactory.makeLoginInspector()
        
        let feedViewController = FeedViewController()
        feedViewController.title = "Лента"
        feedViewController.view.backgroundColor = .lightGray

        let logInViewController = LogInViewController()
        logInViewController.loginDelegate = loginInspector
        _ = UINavigationController(rootViewController: logInViewController)
        
        let profileViewController = ProfileViewController()
        profileViewController.title = "Profile"
        let logPhoto = UIImage(systemName: "person.crop.square.filled.and.at.rectangle.fill")
        logInViewController.tabBarItem = UITabBarItem(title: "Log IN", image: logPhoto, tag: 0)

        let profileNavViewController = UINavigationController(rootViewController: profileViewController)
       
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        
        let profileImage = UIImage(systemName: "person.circle.fill")
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: profileImage, tag: 2)
        
        let feedImage = UIImage(systemName: "house.fill")
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: feedImage, tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [logInViewController,feedNavigationController,profileNavViewController]
        tabBarController.selectedIndex = 0
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window
    }

   
}
