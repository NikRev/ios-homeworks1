import UIKit

class ProfileViewController: UIViewController {
   
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile_image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 50// половина ширины картинки
        
        return imageView
    }()
    
    private let nameUser: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите текст"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
     
        setupSubviews()
        setupConstraints()
        self.title = "Профиль"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        statusLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func labelTapped() {
        let alertController = UIAlertController(title: "Введите текст", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Статус"
        }
        let submitAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first else { return }
            self?.statusLabel.text = textField.text
        }
        alertController.addAction(submitAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func buttonPressed() {
        guard let status = statusLabel.text else { return }
        print("Статус: \(status)")
    }
    
   
    
    private func setupSubviews() {
        view.addSubview(profileImageView)
        view.addSubview(statusLabel)
        view.addSubview(submitButton)
        view.addSubview(nameUser)
        view.addSubview(titleLabel)
        submitButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Ограничения для titleLabel
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),

                
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
  
}
