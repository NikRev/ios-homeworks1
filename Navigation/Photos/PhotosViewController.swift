import UIKit
import iOSIntPackage
import Foundation

class PhotosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
   // private let imagePublisherFacade = ImagePublisherFacade()
    private var myPhotos: [UIImage] = []
   
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let numberOfColumns: CGFloat = 3
        let cellWidth = (UIScreen.main.bounds.width - (numberOfColumns - 1) * 10) / numberOfColumns
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    var photoArray: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavigationBar()
     
        
        processImage()
    }
    
    // MARK: - Setup Methods
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        title = NSLocalizedString("Photo_Gallery_Title", comment: "")
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

   
   
    private func setupImagePublisher() {
        //imagePublisherFacade.subscribe(self)
      //  imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: 4)
     
    }
   
 
    private func applyFilterToImage(image: UIImage) -> UIImage? {
        let context = CIContext(options: nil)
        if let coreImage = CIImage(image: image) {
            let filter = CIFilter(name: "CIPhotoEffectNoir")
            filter?.setValue(coreImage, forKey: kCIInputImageKey)

            if let filteredImage = filter?.outputImage {
                if let cgImage = context.createCGImage(filteredImage, from: filteredImage.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        return nil
    }
    
    private func processImage() {
        let images2: [UIImage] = [
            UIImage(named: "photo1")!,
            UIImage(named: "photo2")!,
            UIImage(named: "photo3")!,
            UIImage(named: "photo4")!
        
        ]
        // Вызываем processImagesOnThread и передаем ей массив изображений с фильтрами
        processImagesOnThread(images: images2, applyFilter: true)
    }

    
    private func processImagesOnThread(images: [UIImage], applyFilter: Bool) {
        let semaphore = DispatchSemaphore(value: 0) // Создаем семафор с начальным значением 0
        var myPhotos: [UIImage] = []
        
        let queue = DispatchQueue.global(qos: .userInteractive) // Создаем глобальную очередь с приоритетом .userInitiated

        let start = DispatchTime.now() // Запускаем таймер до выполнения метода

        queue.async {
            for image in images {
                if applyFilter, let processedImage = self.applyFilterToImage(image: image) {
                    myPhotos.append(processedImage)
                } else {
                    myPhotos.append(image)
                }
            }

            semaphore.signal() // Сигнализируем о завершении
        }

        semaphore.wait() // Ждем, пока семафор получит сигнал

        let end = DispatchTime.now() // Завершаем таймер после выполнения метода
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000 // Время в секундах

        print("Время выполнения processImagesOnThread: \(timeInterval) секунд")

        DispatchQueue.main.async {
            self.photoArray = myPhotos
            self.collectionView.reloadData()
        }
    }



    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotosCollectionViewCell
        let photo = photoArray[indexPath.item]
        cell.imageView.image = photo
        return cell
    }
    
    // MARK: - Other Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

/*
// Расширение для реализации метода receive(images:)
extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        photoArray = images
        collectionView.reloadData()
    }
}
*/
