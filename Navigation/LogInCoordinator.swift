import UIKit

class LogInCoordinator:Coordinator{
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let logInViewController = LogInViewController()
        logInViewController.title = "Log In"
        let logInImage = UIImage(systemName: "person.crop.square.filled.and.at.rectangle.fill")
        logInViewController.tabBarItem = UITabBarItem(title: "Log In", image: logInImage, tag: 2)
        navigationController.setViewControllers([logInViewController], animated: true)
    }
    
    
}
