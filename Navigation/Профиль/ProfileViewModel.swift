import Foundation

class ProfileViewModel {
    var user: User?
    var publications: [Publications] = []
    var onStatusUpdate: ((String) -> Void)?

    init() {
        // Здесь вы загружаете данные о публикациях
        publications = Publications.make() 
    }

    var userName: String {
        return user?.userName ?? "Hipster Cat"
    }

    var userStatus: String {
        return user?.status ?? NSLocalizedString("What's new with you?", comment: "")
    }


   
      
      // Метод для обновления статуса
      func updateUserStatus(newStatus: String) {
          user?.status = newStatus
          
          // Вызываем замыкание для уведомления о новом статусе
          onStatusUpdate?(newStatus)
      }

    
    
    func numberOfSections() -> Int {
        return 2
    }

    func numberOfRowsInSection(section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return publications.count
        }
    }

    func publicationViewModel(at indexPath: IndexPath) -> PublicationViewModel {
        let publication = publications[indexPath.row]
        return PublicationViewModel(publication: publication)
    }

    func estimatedHeightForPublication(_ publication: Publications) -> CGFloat {
        // Рассчитайте высоту на основе содержимого ячейки (текста, изображений и так далее)
        // Верните рассчитанную высоту
        return 400 // Пример минимальной высоты
    }
}
