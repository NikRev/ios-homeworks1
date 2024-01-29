import UIKit
import StorageService
import Foundation
class ProfileHeaderView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    // Метод делегата UITableViewDelegate, возвращающий количество ячеек в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Вернуть количество публикаций в массиве publications
        return publications.count
    }
    
    // Метод делегата UITableViewDelegate, возвращающий ячейку для конкретного индекса пути
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Задайте здесь высоту ячейки
        return 500
    }

    
    
    //Добавить саму таблицу
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var publications: [Publicantions] = []
    
    override init(frame: CGRect) {
          super.init(frame: frame)
        backgroundColor = .white
          setupConstraints() // Вызовите метод setupConstraints для применения ограничений
          setupPublications()
      }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupConstraints()
        setupPublications()
    }
    
    private func setupConstraints() {
        // Добавить таблицу внутри представления header view
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Установить делегаты и источник данных для таблицы
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // Зарегистрировать пользовательскую ячейку для таблицы
        //tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
    }
    
    private func setupPublications() {
        // Создать массив с данными о публикациях (минимум четыре публикации)
        publications = Publicantions.make()
        
        // Перезагрузить таблицу для отображения публикаций
        tableView.reloadData()
    }
}
