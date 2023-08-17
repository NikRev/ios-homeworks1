import UIKit

public class CurrentUserService {
  private var currentUser: User
   var users: [User] = [] // Объявляем массив пользователей
    
    init(currentUser: User) {
        self.currentUser = currentUser
        
        // Инициализация пользователей
        let user1 = User(login: "Никита Ревин", userName: "Никита Ревин", avatar: UIImage(named: "avatar1")!, status: "Online")
        let user2 = User(login: "Екатерина Еникеева", userName: "Екатерина Еникеева", avatar: UIImage(named: "avatar2")!, status: "Offline")
        
        // Добавляем пользователей в массив
        users = [user1, user2]
    }
    
    public func authenticateUser(login: String) -> User? {
        if let user = users.first(where: { $0.login == login  }) {
                   return user
               } else {
                   return nil
               }
       }
}
