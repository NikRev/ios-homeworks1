//
//  PostViewController.swift
//  Navigation
//
//  Created by Никита  on 05.06.2023.
//

import UIKit

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
    
    let post:Post
    init (post:Post){
        self.post = post
        super.init(nibName: nil, bundle: nil)
        title = post.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
