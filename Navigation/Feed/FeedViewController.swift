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
        textField.placeholder = NSLocalizedString("Enter a word", comment: "")
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let checkGuessButton: CustomButton = {
        let button = CustomButton(customBackgroundColor: nil, title: NSLocalizedString("Check", comment: ""), titleColor: .white, cornerRadius: 5)
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
        setupTheme()
        setupUI()
    }
   
    @objc private func handleWordCheckResult(_ notification: Notification) {
           guard let userInfo = notification.userInfo as? [String: Any],
                 let isCorrect = userInfo["isCorrect"] as? Bool else {
               return
           }
        if isCorrect {
            resultLabel.text = NSLocalizedString("Password correct", comment: "")
            resultLabel.textColor = .green
        } else {
            resultLabel.text = NSLocalizedString("Password incorrect", comment: "")
            resultLabel.textColor = .red
        }

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
        view.backgroundColor = .lightBackgroundFeed
        textField.textColor = .lightTextFeed
        //checkGuessButton.setTitleColor(.lightTextFeed, for: .normal)
       
        // Другие настройки для светлой темы
    }

    private func setupDarkTheme() {
        view.backgroundColor = .darkBackgroundFeed
        textField.textColor = .lightTextFeed
        //checkGuessButton.setTitleColor(.darkTextFeed, for: .normal)
        // Другие настройки для темной темы
    }

    
    
    private func setupUI() {
       

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
extension UIColor {
    static let lightBackgroundFeed = UIColor.white
    static let lightTextFeed = UIColor.black
    static let darkBackgroundFeed = UIColor.black
    static let darkTextFeed = UIColor.white
    // Добавьте другие цвета по мере необходимости
}
