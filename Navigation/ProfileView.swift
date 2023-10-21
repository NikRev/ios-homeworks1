import UIKit

class ProfileView: UIView {
    
    private var profileViewModel: ProfileViewModel

    public let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile_image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 50
        return imageView
    }()

    public let nameLabel: UILabel = {
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
        label.text = "Waiting for something...."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.textColor = .gray
        textField.placeholder = "Set your status...."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
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

    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
        setupGestureRecognizers()
        setUserData()
        submitButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside) // Добавляем обработчик для кнопки

    }
  
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "userStatus", let newStatus = change?[.newKey] as? String {
            setStatus(newStatus)
        }
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(submitButton)
    }
    
    func setUserData() {
           nameLabel.text = profileViewModel.userName
        profileImageView.image = UIImage(named: (profileViewModel.user?.avatar ?? "profile_image" as NSObject) as! String)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraints for profileImageView
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),

            // Constraints for nameLabel
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            //nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            

            // Constraints for statusLabel
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            // Constraints for statusTextField
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
            statusTextField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            statusTextField.heightAnchor.constraint(equalToConstant: 30),

            // Constraints for submitButton
            submitButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 30),
            submitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Устанавливаем текст из ProfileViewModel в поле ввода и в label статуса
        setStatus(profileViewModel.userStatus)

        // Подписываемся на изменения текста в поле ввода
        statusTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(statusLabelTapped))
        statusLabel.addGestureRecognizer(tapGesture)
    }

    @objc private func statusLabelTapped() {
        let alertController = UIAlertController(title: "Введите текст", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Статус"
            textField.text = self.statusLabel.text
        }
        let submitAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first else { return }
            self?.statusLabel.text = textField.text
            self?.statusTextField.text = textField.text
            self?.profileViewModel.updateUserStatus(newStatus: textField.text ?? "")
        }
        alertController.addAction(submitAction)

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootViewController = windowScene.windows.first?.rootViewController else { return }
        rootViewController.present(alertController, animated: true, completion: nil)
    }

    @objc private func buttonPressed() {
        guard let status = statusTextField.text else { return }
        profileViewModel.updateUserStatus(newStatus: status) // Вызываем метод обновления статуса в ProfileViewModel
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            profileViewModel.updateUserStatus(newStatus: text) // Обновляем статус в ProfileViewModel при изменении текста в поле ввода
        }
    }

    // Method to set initial status in both label and text field
    func setStatus(_ status: String) {
        statusLabel.text = status
        statusTextField.text = status
    }
}

