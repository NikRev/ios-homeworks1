import UIKit
import CoreData

class FavoriteController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let favoriteService = FavoriteService()
    var favoriteBase = [FavoriteBase]()
    var currentFilter: String?
    
    
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
        
        
        // Добавьте кнопки в NavigationBar
        let filterButton = UIBarButtonItem(title: "Фильтр", style: .plain, target: self, action: #selector(showFilterAlert))
        let clearFilterButton = UIBarButtonItem(title: "Очистить", style: .plain, target: self, action: #selector(clearFilter))
        
        navigationItem.rightBarButtonItems = [filterButton, clearFilterButton]
    }
      
    
    @objc private func showFilterAlert() {
        let alertController = UIAlertController(title: "Фильтр по автору", message: "Введите имя автора", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Имя автора"
        }
        
        let applyAction = UIAlertAction(title: "Применить", style: .default) { [weak self, weak alertController] _ in
            guard let self = self, let alertController = alertController else { return }
            
            // Получите введенное имя автора из текстового поля
            if let authorName = alertController.textFields?.first?.text, !authorName.isEmpty {
                // Установите текущий фильтр и обновите отображаемые элементы
                self.currentFilter = authorName
                self.filterItems()
            } else {
                // Если введено пустое имя, сбросьте текущий фильтр
                self.currentFilter = nil
                self.filterItems()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(applyAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }

    @objc private func clearFilter() {
        // Сбросьте текущий фильтр и обновите отображаемые элементы
        currentFilter = nil
        filterItems()
        
    }

    private func filterItems() {
        if let filter = currentFilter, !filter.isEmpty {
            // Примените фильтр к вашим элементам (вам нужно реализовать этот метод)
            favoriteBase = favoriteService.filterItemsByAuthor(filter)
        } else {
            // Если фильтр пустой, отобразите все элементы
            favoriteBase = favoriteService.getAllItems()
        }
        
        // Обновите таблицу
        tableView.reloadData()
        
    }
    
    private func loadFavoriteData() {
        favoriteService.getAllItems { [weak self] items in
            self?.favoriteBase = items

            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
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
        let rowCount = favoriteBase.count

        // Проверка на наличие данных в CoreData
        if rowCount == 0 {
            // Отобразить сообщение, что данные отсутствуют
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "К сожалению, здесь пока пусто"
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        } else {
            // Очистить сообщение и установить стиль разделителя
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }

        return rowCount
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favoriteService = FavoriteService()

            favoriteService.deleteItem(at: indexPath.row) { [weak self] updatedItems in
                DispatchQueue.main.async { [weak self] in
                    // Обновляем массив данных в контроллере
                    self?.favoriteBase = updatedItems

                    // Обновляем UI, удаляя строку из таблицы
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }

            }
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
