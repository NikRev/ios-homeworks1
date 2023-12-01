import UIKit

class FavoriteCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let favoriteCotroller = FavoriteController()
        favoriteCotroller.title = "Избранное"
        let favoriteImage = UIImage(systemName: "heart")
        favoriteCotroller.tabBarItem = UITabBarItem(title: "Избранное", image: favoriteImage, tag: 5)
        navigationController.setViewControllers([favoriteCotroller], animated: true)
    }
}
