import UIKit
import Foundation


class LogInViewController:UIViewController{
    let colorSet = UIColor(hex: "#4885CC")
    private let logInViewElement = LogInViewElement()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(logInViewElement)
        logInViewElement.translatesAutoresizingMaskIntoConstraints = false
        constraintLogIn()
        navigationController?.navigationBar.isHidden = true
    }
    private func constraintLogIn(){
        NSLayoutConstraint.activate([
            logInViewElement.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logInViewElement.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logInViewElement.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logInViewElement.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
  
    
}
