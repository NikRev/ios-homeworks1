import UIKit
import StorageService

class ProfileViewController: UIViewController {
   
    // Создаем экземпляр ProfileView и таблицы
    private let profileView = ProfileView()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // Массив для хранения публикаций
    private var publications: [Publicantions] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Регистрируем класс ячейки для идентификатора "Cell"
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Cell")
        profileView.translatesAutoresizingMaskIntoConstraints = false

        // Добавляем оба представления на представление контроллера
        view.addSubview(profileView)
        view.addSubview(tableView)
        view.backgroundColor = .lightGray
        
        // Добавляем ProfileHeaderView на представление контроллера
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileHeaderView)
        
        // Устанавливаем ограничения для обоих представлений
        constraintSetup()
        tableView.delegate = self
        tableView.dataSource = self
        publications = Publicantions.make()
    }

    private func constraintSetup() {
        NSLayoutConstraint.activate([
            // Ограничения для profileView
            profileView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            // Ограничения для tableView
            tableView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// Реализация методов UITableViewDelegate и UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Возвращаем количество строк в секции (количество публикаций)
        return publications.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Задайте здесь высоту ячейки
        return 500
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Получить ячейку для указанного индекса пути
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Получить данные публикации для данной ячейки
        let publication = publications[indexPath.row]
        
        // Настроить содержимое ячейки с использованием данных публикации
        cell.textLabel?.text = publication.author
        cell.detailTextLabel?.text = publication.description
        
        // Установить изображение ячейки,  поле image в Publication
        cell.imageView?.image = UIImage(named: publication.image)
        
        return cell
    }
}
