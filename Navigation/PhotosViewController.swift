import UIKit
import iOSIntPackage

protocol ImagePublisherObserver {
    func imagesDidUpdate(images: [UIImage])
}

class PhotosViewController: UIViewController, ImagePublisherObserver {
    let imagePublisherFacade = ImagePublisherFacade()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Другая инициализация вашего контроллера...

        // Регистрируем PhotosViewController как наблюдателя
        imagePublisherFacade.subscribe(self)

        // Начинаем добавлять изображения с интервалом каждые 0.5 секунды, повторяем более чем 10 раз
        imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: 20) // Например, повторяем 20 раз
    }

    func imagesDidUpdate(images: [UIImage]) {
        // Обработка полученных изображений, например, отображение их в интерфейсе
        // Этот метод будет вызван, когда ImagePublisherFacade обновит изображения
    }

    deinit {
        imagePublisherFacade.rechargeImageLibrary()
    }
}

// Расширение PhotosViewController для подписки на протокол ImageLibrarySubscriber
extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage])  {
        guard let firstImage = images.first else {
            print("Получено пустое изображение.")
            return
        }
    }
}

