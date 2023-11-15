import UIKit

class InfoViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private let orbitalPeriodLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.textAlignment = .center
           label.font = UIFont.systemFont(ofSize: 16.0)
           return label
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Отображение UILabel
        view.addSubview(titleLabel)
        view.addSubview(orbitalPeriodLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30), // Смещение вверх
            
            orbitalPeriodLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orbitalPeriodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        
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
                           if let orbitalPeriod = jsonModel.orbitalPeriod {
                               self.orbitalPeriodLabel.text = "Orbital Period: \(orbitalPeriod)"
                           } else {
                               self.orbitalPeriodLabel.text = "Orbital Period not available"
                           }
                       }
                   case .failure(let error):
                       print("Error during fetch: \(error)")
                   }
               }
        
        
        // Установка текста UILabel из значения поля title
        titleLabel.text = "Значение title"

        let showAlertButton = UIButton(type: .system)
        showAlertButton.setTitle("Я кнопка показа alert", for: .normal)
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        showAlertButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(showAlertButton)
        NSLayoutConstraint.activate([
            showAlertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showAlertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30) // Смещение вниз
        ])
    }

    @objc private func showAlert() {
        let alertController = UIAlertController(title: "Сообщение", message: "Привет", preferredStyle: .alert)

        let action1 = UIAlertAction(title: "Сообщение номер раз", style: .default) { [weak self] _ in
            guard self != nil else { return }
            print("Сообщение 1")
        }

        let action2 = UIAlertAction(title: "Сообщение номер два", style: .default) { [weak self] _ in
            guard self != nil else { return }
            print("Сообщение 2")
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        present(alertController, animated: true, completion: nil)
    }
}
