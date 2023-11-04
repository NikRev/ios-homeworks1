import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    let colorSet = UIColor(named: "ColorSet")
    let paddedTextField = PaddedTextField()
    var loginDelegate: LoginViewControllerDelegate?
    
    let bruteForceSolver = BruteForce()
    let activityIndicator = UIActivityIndicatorView()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
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
        textField.textEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        textField.placeholder = "Phone or Email"
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
        textField.textEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let generatePasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подобрать пароль", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(generatePassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let buttonVk: CustomButton = {
        let button = CustomButton(customBackgroundColor: nil, title: "Log In", titleColor: .white, cornerRadius: 10)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.addTarget(self, action: #selector(buttonLogFunc), for: .touchUpInside)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var generatedPassword: String?

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

        buttonVk.addTarget(self, action: #selector(buttonLogFunc), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white

        loginTextField.delegate = self
        passwordTextField.delegate = self

        setupAdd()
        setupConstraints()
        setupKeyboardObservers()
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


    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

    @objc private func generatePassword() {
        if let loginText = loginTextField.text, !loginText.isEmpty {
            let result = bruteForceSolver.bruteForce(in: loginText)
            let characters = String(result.letters)
            let numbers = result.numbers
            let length = 12 // Вы можете установить желаемую длину сгенерированного пароля

            if characters.isEmpty && numbers.isEmpty {
                let alert = UIAlertController(title: "Ошибка", message: "Не найдено символов для генерации пароля", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                let password = generateRandomPassword(length: length, characters: characters, numbers: numbers)
                generatedPassword = password
                passwordTextField.text = password
            }
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Поле ввода логина пустое", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    func generateRandomPassword(length: Int, characters: String, numbers: [Int]) -> String {
        var password = ""
        let characterCount = characters.count
        let numberCount = numbers.count

        for _ in 0..<length {
            let isCharacter = Bool.random() // Случайно выбираем между символом и числом
            if isCharacter && characterCount > 0 {
                let randomIndex = Int.random(in: 0..<characterCount)
                password.append(characters[characters.index(characters.startIndex, offsetBy: randomIndex)])
            } else if numberCount > 0 {
                let randomIndex = Int.random(in: 0..<numberCount)
                password.append(String(numbers[randomIndex]))
            }
        }

        return password
    }


    @objc private func buttonLogFunc() {
            if let loginText = loginTextField.text, !loginText.isEmpty {
                if let generatedPassword = generatedPassword {
                    activityIndicator.startAnimating()

                    DispatchQueue.global(qos: .background).async { [weak self] in
                        guard let self = self else { return }

                        let isLoginValid = self.tryToAuthenticate(login: loginText, password: generatedPassword)

                        DispatchQueue.main.async {
                            self.activityIndicator.stopAnimating()

                            if isLoginValid {
                                let profileVC = ProfileViewController()
                                self.navigationController?.pushViewController(profileVC, animated: true)
                            } else {
                                let alert = UIAlertController(title: "Ошибка", message: "Пользователь с таким логином и паролем не найден", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                } else {
                    let alert = UIAlertController(title: "Ошибка", message: "Сначала сгенерируйте пароль", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    
    func tryToAuthenticate(login: String, password: String) -> Bool {
          
           // Верните true, если аутентификация прошла успешно, иначе false.
           return false
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
        view.addSubview(scrollView)
        view.addSubview(imageVK)
        view.addSubview(buttonVk)
        view.addSubview(generatePasswordButton) // Add the generate password button

        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)

        // Add the activity indicator to the view
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageVK.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            imageVK.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: imageVK.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),

            buttonVk.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            buttonVk.heightAnchor.constraint(equalToConstant: 50),
            buttonVk.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonVk.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            generatePasswordButton.topAnchor.constraint(equalTo: buttonVk.bottomAnchor, constant: 16), // Set the position of the generate password button
            generatePasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Center the generate password button

            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor), // Center the activity indicator
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}



extension UIResponder {
    private static weak var _currentFirstResponder: UIResponder? = nil
    
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }
    
    @objc func findFirstResponder() {
        UIResponder._currentFirstResponder = self
    }
}
