import UIKit
import CoreData

class FavoriteController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let favoriteService = FavoriteService()
    var favoriteBase = [FavoriteBase]()
   
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          // Загружаем свежие данные в таблицы и в CoreDate
          loadFavoriteData()
      }
     
      override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = .white
          
          // Настройка и отображение таблицы
          layout()
      }
      
      private func loadFavoriteData() {
          // Загрузка данных из сервиса
          favoriteBase = favoriteService.getAllItems()

         
          DispatchQueue.main.async {
              self.tableView.reloadData()
          }
      }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
        return tableView
    }()
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteBase.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Вызываем метод удаления из CoreData
            favoriteService.deleteItem(at: indexPath.row)
            
            // Удаляем элемент из массива и обновляем таблицу
            favoriteBase.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }


    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100  // Установите начальную оценку высоты ячейки
    }


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier, for: indexPath) as? FavoriteCell else {
            return UITableViewCell()
        }
        
        let favoriteItem = favoriteBase[indexPath.row]
        
        // Убедитесь, что title не является nil перед использованием
        if let author = favoriteItem.author {
            cell.configure(with: author, author: "Author", imageURL: "")
        } else {
            // Если title равен nil, выполните соответствующие действия или просто не вызывайте configure
            // cell.configure(with: "", author: "Author", imageURL: "ImageURL")
            print("++")
        }
        // Отключение выделения ячейки при тапе
           cell.selectionStyle = .none
        return cell
    }
}
