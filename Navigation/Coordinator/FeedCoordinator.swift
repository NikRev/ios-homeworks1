import UIKit

class FeedCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let feedViewController = FeedViewController()
        feedViewController.title = "Лента"
        let feedImage = UIImage(systemName: "house.fill")
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: feedImage, tag: 1)
        navigationController.setViewControllers([feedViewController], animated: true)
    }
}
