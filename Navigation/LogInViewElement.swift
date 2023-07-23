import UIKit

class PaddedTextField: UITextField {
    var textEdgeInsets: UIEdgeInsets = .zero {
        didSet { setNeedsDisplay() }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textEdgeInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textEdgeInsets)
    }
}

class LogInViewElement: UIView {
   

    private let imageVK: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ФотоВк")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    private let loginTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor.systemBlue
        textField.autocapitalizationType = .none
        textField.textEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0) // Добавление отступа слева
        textField.placeholder = "Phone or Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: PaddedTextField = {
       
        let textField = PaddedTextField()
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor.systemBlue
        textField.autocapitalizationType = .none
        textField.textEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0) // Добавление отступа слева
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let buttonVk: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal) // Use setBackgroundImage instead of backgroundImage(for:)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14) // Set the font for the title label
        button.setTitleColor(.white, for: .normal) // Set the title color
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc private func buttonLogFunc() {
        // Проверка на пустые поля с помощью if let
        if let loginText = loginTextField.text, !loginText.isEmpty,
           let passwordText = passwordTextField.text, !passwordText.isEmpty {
            // Все поля заполнены, можно продолжать
            let profileViewContr = ProfileViewController()
            navigationController?.pushViewController(profileViewContr, animated: true)
        } else {
            // Выдать алерт, что данные не заполнены
            let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        buttonVk.addTarget(self, action: #selector(buttonLogFunc), for: .touchUpInside)
        
               
        setupAdd()
        setupConstraints()
    }
    
    @objc private func handleTap(){
        self.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAdd() {
       
        addSubview(imageVK)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(buttonVk)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Констрейнты для imageView
            imageVK.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            imageVK.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Констрейнты для loginTextField
            loginTextField.topAnchor.constraint(equalTo: imageVK.bottomAnchor, constant: 20),
            loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Констрейнты для passwordTextField
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Констрейнты для buttonLog
            buttonVk.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            buttonVk.heightAnchor.constraint(equalToConstant: 50),
            buttonVk.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonVk.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            
        ])
    }
}
