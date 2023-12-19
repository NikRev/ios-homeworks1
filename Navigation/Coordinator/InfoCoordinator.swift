import UIKit

class InfoCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let infoViewController = InfoViewController()
        infoViewController.title = NSLocalizedString("Info", comment: "")
        let infoImage = UIImage(systemName: "info.bubble")
        infoViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Info", comment: ""), image: infoImage, tag: 4)
        navigationController.setViewControllers([infoViewController], animated: true)
    }

}
