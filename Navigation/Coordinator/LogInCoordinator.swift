import UIKit

class LogInCoordinator:Coordinator{
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let logInViewController = LogInViewController()
        logInViewController.title = NSLocalizedString("LogIn", comment: "")
        let logInImage = UIImage(systemName: "person.crop.square.filled.and.at.rectangle.fill")
        logInViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("LogIn", comment: ""), image: logInImage, tag: 2)
        navigationController.setViewControllers([logInViewController], animated: true)
    }

    
    
}
