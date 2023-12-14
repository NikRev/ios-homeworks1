import UIKit



class LogInViewController: UIViewController {
    let colorSet = UIColor(named: "ColorSet")
    let paddedTextField = PaddedTextField()
    weak var loginDelegate:LoginViewControllerDelegate?
    
   

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
   
    let buttonRegister: CustomButton = {
        let button = CustomButton(customBackgroundColor: .gray, title: NSLocalizedString("Register", comment: ""), titleColor: .white, cornerRadius: 10)
      //  button.setBackgroundImage(UIImage(named: "green_pixel"), for: .normal)
        button.addTarget(self, action: #selector(buttonRegisterFunc), for: .touchUpInside)
        button.backgroundColor = .gray
        button.clipsToBounds = true // обрезать содержимое кнопки
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        return stackView
    }()
    
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
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor.systemBlue
        textField.autocapitalizationType = .none
        textField.textEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0) // Добавление отступа слева
        textField.placeholder = NSLocalizedString("Phone or Email", comment: "")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor.systemBlue
        textField.autocapitalizationType = .none
        textField.textEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0) // Добавление отступа слева
        textField.placeholder = NSLocalizedString("Password", comment: "")
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    let buttonVk: CustomButton = {
        let button = CustomButton(customBackgroundColor: nil, title: NSLocalizedString("LogIn",comment: "'"), titleColor: .white, cornerRadius: 10)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.addTarget(self, action: #selector(buttonLogFunc), for: .touchUpInside)
        button.clipsToBounds = true // обрезать содержимое кнопки
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGesture)

        buttonRegister.addTarget(self, action: #selector(buttonRegisterFunc), for: .touchUpInside)

        buttonVk.addTarget(self, action: #selector(buttonLogFunc), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        setupAdd()
        setupConstraints()
        setupKeyboardObservers()
        setupTheme()

    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    
    @objc private func handleTap() {
        scrollView.endEditing(true)
    }

   
    @objc func willShowKeyboard(_ notification: NSNotification) {
        if let activeTextField = UIResponder.currentFirstResponder as? UITextField,
           let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
               
           let keyboardHeight = keyboardFrame.size.height
           let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
               
           scrollView.contentInset = contentInsets
           scrollView.scrollIndicatorInsets = contentInsets
               
            var visibleRect = activeTextField.convert(activeTextField.bounds, to: scrollView)
            visibleRect = visibleRect.insetBy(dx: 0, dy: -10)
            scrollView.scrollRectToVisible(visibleRect, animated: true)
           }
    }
    
    @objc private func buttonRegisterFunc() {
        guard let loginText = loginTextField.text, !loginText.isEmpty,
              let passwordText = passwordTextField.text, !passwordText.isEmpty else {
            self.showAlert(title: "Error", message: "Please enter both login and password")
            return
        }

        loginDelegate?.checkCredentials(email: loginText, password: passwordText) { [weak self] success, errorDescription in
            guard let self = self else { return }

            if success {
                // Authentication successful, proceed with registration
                self.loginDelegate?.signUp(email: loginText, password: passwordText) { signUpSuccess, signUpErrorDescription in
                    if signUpSuccess {
                        // Registration successful, navigate to the next screen
                        let profileViewController = ProfileViewController()
                        self.navigationController?.pushViewController(profileViewController, animated: true)
                    } else {
                        // Registration error, show an alert with the error description
                        self.showAlert(title: "Registration Error", message: signUpErrorDescription ?? "Unknown error during registration")
                    }
                }
            } else {
                // Authentication error, show an alert with the error description
                self.showAlert(title: "Authentication Error", message: errorDescription ?? "Invalid credentials")
            }
        }
    }

    
    
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

    
    @objc private func buttonLogFunc() {
        guard let loginText = loginTextField.text, !loginText.isEmpty,
              let passwordText = passwordTextField.text, !passwordText.isEmpty else {
            self.showAlert(title: "Login Error", message: "Please enter both login and password")
            return
        }
        
        loginDelegate?.checkCredentials(email: loginText, password: passwordText) { [unowned self] success, errorDescription in
            if success {
                // Authentication successful
                let profileViewController = ProfileViewController()
                self.navigationController?.pushViewController(profileViewController, animated: true)
            } else {
                // Authentication error, show an alert with the error description
                self.showAlert(title: "Login Error", message: errorDescription ?? "Unknown error during Login")
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    private func setupTheme() {
        updateTheme(traitCollection.userInterfaceStyle)
        
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateTheme(traitCollection.userInterfaceStyle)
        }
        
    }

    private func updateTheme(_ userInterfaceStyle: UIUserInterfaceStyle) {
        if userInterfaceStyle == .dark {
            setupDarkTheme()
        } else {
            setupLightTheme()
        }
        
    }

    private func setupLightTheme() {
        view.backgroundColor = .lightBackground
        // Другие настройки для светлой темы
        
    }

    private func setupDarkTheme() {
        view.backgroundColor = .darkBackground
        // Другие настройки для темной темы
        
    }
    

    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
     func setupAdd() {
        scrollView.addSubview(stackView)
        scrollView.addSubview(imageVK)
        scrollView.addSubview(buttonVk)
        scrollView.addSubview(buttonRegister)
        view.addSubview(scrollView)
        view.addSubview(imageVK)
        view.addSubview(buttonVk)
        view.addSubview(buttonRegister)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        
    }

    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Констрейнты для imageView
            imageVK.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            imageVK.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Констрейнты для scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Констрейнты для stackView
            stackView.topAnchor.constraint(equalTo: imageVK.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            // Констрейнты для buttonLog
            buttonVk.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            buttonVk.heightAnchor.constraint(equalToConstant: 50),
            buttonVk.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonVk.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            buttonRegister.topAnchor.constraint(equalTo: buttonVk.bottomAnchor, constant: 16),
            buttonRegister.heightAnchor.constraint(equalToConstant: 50),
            buttonRegister.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonRegister.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}


extension UIResponder {
    static weak var currentFirstResponder: UIResponder? = nil

    public func findFirstResponder() {
        UIResponder.currentFirstResponder = self
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UIColor {
    static let lightBackgroundLog = UIColor.white
    static let lightTextLog = UIColor.black
    static let darkBackgroundLog = UIColor.black
    static let darkTextLog = UIColor.white
    // Добавьте другие цвета по мере необходимости
}
