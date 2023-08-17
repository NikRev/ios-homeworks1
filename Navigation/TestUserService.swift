import UIKit

public class TestUserService{
     var TestUserServce1:UserService
    public var userTest:[ User] = []
    
    init(TestUserServce1: UserService) {
        self.TestUserServce1 = TestUserServce1
        let user1 = User(login: "Никита Зварыкин", userName: "Никита Зварыкин", avatar: UIImage(named: "avatar1")!, status: "Online")
        let user2 = User(login: "Игорь Рекутенко", userName: "Игорь Рекутенко", avatar: UIImage(named: "avatar2")!, status: "Offline")
        
        // Добавляем пользователей в массив
        userTest = [user1, user2]
    }
    
    public func authenticateUser(login: String) -> User? {
        if let user = userTest.first(where: { $0.login == login }) {
                   return user
               } else {
                   return nil
               }
       }
}




