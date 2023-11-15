import UIKit

class InfoCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let infoViewController = InfoViewController()
        infoViewController.title = "Инфо"
        let infoImage = UIImage(systemName: "info.bubble")
        infoViewController.tabBarItem = UITabBarItem(title: "Инфо", image: infoImage, tag: 4)
        navigationController.setViewControllers([infoViewController], animated: true)
    }
}
