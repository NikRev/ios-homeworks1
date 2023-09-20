import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let collectionView: UICollectionView = {
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
    
    let photo0 = UIImage(named: "Photo-1")
    let photo1 = UIImage(named: "Photo0")
    let photo2 = UIImage(named: "Photo2")
    let photo3 = UIImage(named: "Photo3")
    let photo4 = UIImage(named: "Photo4")
    let photo5 = UIImage(named: "Photo5")
    let photo6 = UIImage(named: "Photo6")
    
    // Здесь вы можете добавить свой массив фотографий или данные, которые будут отображаться в коллекции
   public  var photos: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Создайте массив фактических изображений в методе viewDidLoad
         photos = [photo0, photo1, photo2, photo3, photo4, photo5, photo6].compactMap { $0 }
                
        // Добавляем коллекцию на экран
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Устанавливаем constraints для коллекции
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Настраиваем навигационный бар
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Скрываем навигационный бар при уходе с экрана
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        
        // Настройте содержимое ячейки с фотографией
        cell.configure(with: photos[indexPath.item])
        
        return cell
    }
}
