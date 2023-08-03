import UIKit
import Foundation

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

class LogInViewController:UIViewController{
    let colorSet = UIColor(hex: "#4885CC")

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
    setupAdd()
    setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    scrollView.contentSize = CGSize(width: view.frame.width, height: buttonVk.frame.maxY + 16)
        }
    
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
        stackView.layer.cornerRadius = 20
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
         textField.layer.cornerRadius = 0
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
         textField.layer.cornerRadius = 0
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
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = button.frame.height / 2 // Установите радиус скругления равным половине высоты кнопки
        button.clipsToBounds = true // Обрезать содержимое кнопки, чтобы соответствовать радиусу скругления
        button.translatesAutoresizingMaskIntoConstraints = false
       
        return button
    }()

    
    @objc private func handleTap(){
        self.view.endEditing(true)
    }

    @objc private func buttonLogFunc() {
        // Проверка на пустые поля с помощью if let
        if let loginText = loginTextField.text, !loginText.isEmpty,
            let passwordText = passwordTextField.text, !passwordText.isEmpty {
            // Все поля заполнены, можно продолжать
            print("Все поля заполнены, выполняю переход")
            let profileViewContr = ProfileViewController()
            navigationController?.pushViewController(profileViewContr, animated: true)
            tabBarController?.selectedIndex = 2

           // present(profileViewContr, animated: true)
        } else {
            // Выдать алерт, что данные не заполнены
            print("Данные не заполнены, не выполняю переход")
            let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

     private func setupAdd() {
     stackView.addArrangedSubview(loginTextField)
     stackView.addArrangedSubview(passwordTextField)
     view.addSubview(stackView)
     view.addSubview(imageVK)
     view.addSubview(buttonVk)
     view.addSubview(scrollView)
     scrollView.addSubview(stackView)
     scrollView.addSubview(imageVK)
     scrollView.addSubview(buttonVk)
       
     }
     
     private func setupConstraints() {
         NSLayoutConstraint.activate([
             // Констрейнты для imageView
            imageVK.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            imageVK.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //Констрейнты для scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Констрейнты для stackView
            stackView.topAnchor.constraint(equalTo: imageVK.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 80), //
             
             // Констрейнты для buttonLog
            buttonVk.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            buttonVk.heightAnchor.constraint(equalToConstant: 50),
            buttonVk.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonVk.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
         ])
     }
 }

    
    
   
    

