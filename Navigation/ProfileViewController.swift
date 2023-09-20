import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    let photo0 = UIImage(named: "Photo-1")
    let photo1 = UIImage(named: "Photo0")
    let photo2 = UIImage(named: "Photo2")
    let photo3 = UIImage(named: "Photo3")
    let photo4 = UIImage(named: "Photo4")
    let photo5 = UIImage(named: "Photo5")
    let photo6 = UIImage(named: "Photo6")
     var photos: [UIImage] = []

    let stackView: UIStackView = {
          let stackView = UIStackView()
          stackView.translatesAutoresizingMaskIntoConstraints = false
          stackView.axis = .vertical
          return stackView
      }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        return collectionView
    }()

    
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var publications: [Publicantions] = []
  
    
    override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(stackView)
            tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Cell")
            view.addSubview(tableView)
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 450 // Задайте начальное оценочное значение, но оно будет динамически скорректировано
            constraintSetup()
            tableView.delegate = self
            tableView.dataSource = self
            publications = Publicantions.make()
           view.addSubview(collectionView)
           collectionView.delegate = self
           collectionView.dataSource = self
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
               tapGesture.delegate = self
               view.addGestureRecognizer(tapGesture)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(collectionView)

        // Заполните массив фотографий (ваш код может отличаться)
           photos = [photo0, photo1, photo2, photo3, photo4, photo5, photo6].compactMap { $0 }
       
        }

    @objc private func handleTap() {
            // End editing on the text field to dismiss the keyboard
            view.endEditing(true)
        
        }

    private func constraintSetup() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}





extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // Возвращаем количество секций (например, 2 для таблицы и коллекции)
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // Возвращаем количество строк для первой секции (например, количество публикаций)
            return publications.count
        } else if section == 1 {
            // Возвращаем количество строк для второй секции (например, количество фотографий)
            return 1
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // Настроить и вернуть ячейку для первой секции (публикации)
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
            let publication = publications[indexPath.row]
            cell.configure(with: publication)
            return cell
        } else if indexPath.section == 1 {
            // Настроить и вернуть ячейку для второй секции (коллекции)
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewCell", for: indexPath)
            
            // Настроить коллекцию внутри этой ячейки
            cell.addSubview(collectionView)
            collectionView.frame = cell.bounds
            
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Возвращаем соответствующую высоту строк для каждой секции
        if indexPath.section == 0 {
            return 400
        } else if indexPath.section == 1 {
            // Подстройте высоту для ячейки коллекции по мере необходимости
            return collectionView.collectionViewLayout.collectionViewContentSize.height
        }
        return UITableView.automaticDimension
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        cell.configure(with: photos[indexPath.item])
        return cell
    }
}

