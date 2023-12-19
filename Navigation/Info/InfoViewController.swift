import UIKit

class InfoViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.numberOfLines = 0 // Многоколоночный режим
        return label
    }()

    private let orbitalPeriodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 0 // Многоколоночный режим
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheme()

        // Отображение UILabel
        view.addSubview(titleLabel)
        view.addSubview(orbitalPeriodLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30), // Смещение от верхнего края safe area
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -40), // Максимальная ширина

            orbitalPeriodLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orbitalPeriodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            orbitalPeriodLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -40) // Максимальная ширина
        ])

        // Вызываем функцию fetch и передаем замыкание для обработки данных JSON
        JsonSerialization().fetch { result in
            switch result {
            case .success(let jsonModel):
                DispatchQueue.main.async {
                    // Обновляем текст UILabel с данными из JSON
                    self.titleLabel.text = jsonModel.title
                }
            case .failure(let error):
                print("Error during fetch: \(error)")
            }
        }

        // Вызываем функцию fetch и передаем замыкание для обработки данных JSON
        JsonCodableDataTask().fetchPlanet { result in
            switch result {
            case .success(let jsonModel):
                DispatchQueue.main.async {
                    // Отображаем orbital_period в orbitalPeriodLabel
                    if let orbitalPeriod = jsonModel.orbitalPeriod, !orbitalPeriod.isEmpty {
                        self.orbitalPeriodLabel.text = NSLocalizedString("Orbital Period", comment: "") + ": \(orbitalPeriod)"
                    } else {
                        self.orbitalPeriodLabel.text = NSLocalizedString("Orbital Period not available", comment: "")
                    }


                }
            case .failure(let error):
                print("Error during fetch: \(error)")
            }
        }

        titleLabel.text = NSLocalizedString("Title Value", comment: "")

        let showAlertButton = UIButton(type: .system)
        showAlertButton.setTitle(NSLocalizedString("I'm an alert button", comment: ""), for: .normal)
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        showAlertButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(showAlertButton)
        NSLayoutConstraint.activate([
            showAlertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showAlertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30) // Смещение вниз
        ])
    }

    @objc private func showAlert() {
        let alertController = UIAlertController(title: NSLocalizedString("Message", comment: ""),
                                                message: NSLocalizedString("Hello", comment: ""),
                                                preferredStyle: .alert)

        let action1 = UIAlertAction(title: NSLocalizedString("Message Number One", comment: ""), style: .default) { [weak self] _ in
            guard self != nil else { return }
            print("Message 1")
        }

        let action2 = UIAlertAction(title: NSLocalizedString("Message Number Two", comment: ""), style: .default) { [weak self] _ in
            guard self != nil else { return }
            print("Message 2")
        }

        alertController.addAction(action1)
        alertController.addAction(action2)
        present(alertController, animated: true, completion: nil)
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
        view.backgroundColor = .lightBackgroundInfo
        titleLabel.textColor = .lightTextInfo
        orbitalPeriodLabel.textColor = .lightTextInfo
        // Другие настройки для светлой темы
        
    }

    private func setupDarkTheme() {
        view.backgroundColor = .darkBackgroundInfo
        titleLabel.textColor = .darkTextInfo
        orbitalPeriodLabel.textColor = .darkTextInfo
        // Другие настройки для темной темы
    }
   
}

extension UIColor {
    static let lightBackgroundInfo = UIColor.white
    static let lightTextInfo  = UIColor.black
    static let darkBackgroundInfo  = UIColor.black
    static let darkTextInfo  = UIColor.white
    // Добавьте другие цвета по мере необходимости
}
