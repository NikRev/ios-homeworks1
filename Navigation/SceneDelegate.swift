import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let feedViewController = FeedViewController()
        feedViewController.title = "Лента"
        feedViewController.view.backgroundColor = .gray
        
        let profileViewController = ProfileViewController()
        profileViewController.title = "Profile"
        
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        
        let profileImage = UIImage(systemName: "person.circle.fill")
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: profileImage, tag: 1)
        
        let feedImage = UIImage(systemName: "house.fill")
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: feedImage, tag: 0)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [feedNavigationController, profileViewController]
        tabBarController.selectedIndex = 0
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
       
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
       
    }
}
