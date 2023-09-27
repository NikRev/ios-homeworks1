
import UIKit
import Foundation

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выбранный пост"
        view.backgroundColor = .white
        let infoButton = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showInfoViewController))
        navigationItem.rightBarButtonItem = infoButton
        // Do any additional setup after loading the view.
    }
  
    @objc private func showInfoViewController(){
        let infoViewController = InfoViewController()
        let navigationController = UINavigationController (rootViewController: infoViewController)
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true,completion: nil)
    }
    
    public let post:Post1
    init (post:Post1){
        self.post = post
        super.init(nibName: nil, bundle: nil)
        
    }
    
   public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
