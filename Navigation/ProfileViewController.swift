import UIKit

class ProfileViewController: UIViewController {
        
        private let profileView = ProfileView()
       
       
        override func viewDidLoad() {
            super.viewDidLoad()
           
            view.backgroundColor = .lightGray
            view.addSubview(profileView)
            profileView.translatesAutoresizingMaskIntoConstraints = false
           
            NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            }
        }
           
   
    
   
    
    
   
   
    
   
    
   
    
    
/*
            // Ограничения для profileImageView
               profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
               profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               profileImageView.widthAnchor.constraint(equalToConstant: 100),
               profileImageView.heightAnchor.constraint(equalToConstant: 100),
               
               // Ограничения для nameUser
               nameUser.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 35),
               nameUser.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
               
               // Ограничения для statusLabel
               statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               statusLabel.topAnchor.constraint(equalTo: nameUser.bottomAnchor, constant: 16),
               
               // Ограничения для submitButton
               submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               submitButton.heightAnchor.constraint(equalToConstant: 50),
               submitButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 20)
        ])


    }
  
 }*/
