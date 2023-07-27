import UIKit
import StorageService
class ProfileView: UIView {
    
    
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
        button.setTitle("Set Status", for: .normal)
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
    
    init() {
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
        setupGestureRecognizers()
        submitButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside) // Добавлен addTarget для кнопки submitButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(profileImageView)
        addSubview(nameUser)
        addSubview(statusLabel)
        addSubview(submitButton)
    }
    
    func setupGestureRecognizers() {
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(statusLabelTapped))
       statusLabel.addGestureRecognizer(tapGesture)
   }

   
   @objc private func statusLabelTapped() {
       let alertController = UIAlertController(title: "Введите текст", message: nil, preferredStyle: .alert)
       alertController.addTextField { textField in
           textField.placeholder = "Статус"
       }
       let submitAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
           guard let textField = alertController.textFields?.first else { return }
           self?.statusLabel.text = textField.text
       }
       alertController.addAction(submitAction)
       
       guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
             let rootViewController = windowScene.windows.first?.rootViewController else { return }
       rootViewController.present(alertController, animated: true, completion: nil)
   }
@objc private func buttonPressed() {
        guard let status = statusLabel.text else { return }
        print("Статус: \(status)")
    }

  

  
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Ограничения для profileImageView
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            // Ограничения для nameLabel
            nameUser.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            nameUser.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
           
            
            // Ограничения для statusLabel
            statusLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -20),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 135),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            // Ограничения для submitButton
            submitButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            submitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
     

    
}



