// PhotosViewController.swift
import UIKit

class PhotosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        // Рассчитываем ширину каждой ячейки в зависимости от количества столбцов (3 в данном случае)
        let numberOfColumns: CGFloat = 3
        let cellWidth = (UIScreen.main.bounds.width - (numberOfColumns - 1) * 10) / numberOfColumns
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth) // Высота равна ширине для квадратных ячеек

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white

        return collectionView
    }()
    
    private var photoArray: [UIImage?] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photo Gallery"
        view.addSubview(collectionView)
        
       
        let photo1 = UIImage(named: "photo1")
        let photo2 = UIImage(named: "photo2")
        let photo3 = UIImage(named: "photo3")
        let photo4 = UIImage(named: "photo4")
        
        
        photoArray = [photo1, photo2, photo3, photo4]
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Скрываем NavigationBar при загрузке экрана
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Здесь возвращаем количество фотографий в вашей коллекции
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotosCollectionViewCell
        
        // Здесь настраиваем ячейку коллекции с использованием фотографии из вашего массива
        let photo = photoArray[indexPath.item] // Замените `yourPhotoArray` на ваш массив фотографий
        cell.imageView.image = photo // Предполагается, что `imageView` - это `UIImageView` в вашей ячейке
        
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Показываем NavigationBar перед отображением экрана
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Скрываем NavigationBar при уходе с экрана
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}
