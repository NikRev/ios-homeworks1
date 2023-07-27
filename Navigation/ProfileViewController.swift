import UIKit
import StorageService

class ProfileViewController: UIViewController {
   
    // Создаем экземпляр ProfileView и таблицы
    private let profileView = ProfileView()
    private let tableView: UITableView = {
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
        
        // Add the table view to the view controller's view and set its constraints
        view.addSubview(profileView)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Set the delegate and dataSource for the table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // Load publications data into the array
        publications = Publicantions.make()
    }


}

// Реализация методов UITableViewDelegate и UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Возвращаем количество строк в секции (количество публикаций)
        return publications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Получаем ячейку для соответствующей публикации
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell // Указываем класс ячейки
        let publication = publications[indexPath.row]
        
        // Настраиваем содержимое ячейки с данными о публикации
        cell.configure(with: publication) // Вызываем метод configure для настройки ячейки
        // Здесь также можно установить изображение для ячейки, используя имя изображения из publication.image
        
        return cell
    }
    
    // ...
}
