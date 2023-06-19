//
//  FeedViewController.swift
//  Navigation
//
//  Created by Никита  on 04.06.2023.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .system)
        button.setTitle("Показать пост", for: .normal)
        button.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)])

        // Do any additional setup after loading the view.
    }
    @objc private func showPost() {
        let post = Post (title: "Заголовок поста")

        let postViewContorlller = PostViewController(post: post)
        navigationController?.pushViewController(postViewContorlller, animated: true)
    }

  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    

}
