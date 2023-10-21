import UIKit


protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let profileViewController = ProfileViewController()
        profileViewController.title = "Профиль"
        let profileImage = UIImage(systemName: "person.circle.fill")
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: profileImage, tag: 0)
        navigationController.setViewControllers([profileViewController], animated: true)
    }
}
