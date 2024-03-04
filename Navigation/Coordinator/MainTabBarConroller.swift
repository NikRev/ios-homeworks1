import UIKit

final class MainTabBarConroller:UITabBarController{
    private let firstVC = Factory(flow: .first)
    private let secondVC = Factory(flow: .second)
    private let thirdVC = Factory(flow: .third)
    private let fourthVC = Factory(flow: .fourth)
    private let fifthVC = Factory(flow: .fifth)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContoller()
    }
   
    func setContoller(){
    viewControllers = [
        firstVC.navigationController,
        secondVC.navigationController,
        thirdVC.navigationController,
        fourthVC.navigationController,
        fifthVC.navigationController
       ]
    }
    
}
