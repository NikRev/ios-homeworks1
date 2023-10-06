import UIKit

class FeedViewController: UIViewController {

    
    private let resultLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.textAlignment = .center
           return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите слово"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let checkGuessButton: CustomButton = {
        let button = CustomButton(customBackgroundColor: nil, title: "Проверить", titleColor: .white, cornerRadius: 5)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.clipsToBounds = true // обрезать содержимое кнопки
        button.addTarget(self, action: #selector(checkGuess), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let feedModel = FeedModel(secretWord: "ваш_секретный_пароль")

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleWordCheckResult(_:)), name: NSNotification.Name(rawValue: "WordCheckResult"), object: nil)

        setupUI()
    }
   
    @objc private func handleWordCheckResult(_ notification: Notification) {
           guard let userInfo = notification.userInfo as? [String: Any],
                 let isCorrect = userInfo["isCorrect"] as? Bool else {
               return
           }
           if isCorrect {
               resultLabel.text = "Пароль верный"
               resultLabel.textColor = .green
           } else {
               resultLabel.text = "Пароль неверный"
               resultLabel.textColor = .red
           }
    }
    
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(textField)
        view.addSubview(checkGuessButton)
        view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200),

            checkGuessButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            checkGuessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 16),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    @objc private func checkGuess() {
          guard let guessedWord = textField.text, !guessedWord.isEmpty else {
              return
          }

          feedModel.check(word: guessedWord)
      }
   
   
}
