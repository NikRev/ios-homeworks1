import UIKit

public protocol UserService {
    func authenticateUser(login: String) -> User?
}

enum Users {
    case main
    case test
    
    var instance: User {
            switch self {
            case .main:
                if let avatarImage = UIImage(named: "avatar1") {
                    return User(login: "main", userName: "Main User", avatar: avatarImage, status: "Main User Status")
                }
            case .test:
                if let avatarImage = UIImage(named: "avatar2") {
                    return User(login: "test", userName: "Test User", avatar: avatarImage, status: "Test User Status")
                }
            }
            fatalError("Не удалось создать экземпляр User.")
        }
}


public class User {
    var login: String
    var userName: String
    var avatar: UIImage
    var status: String
    
    init(login: String, userName: String, avatar: UIImage, status: String) {
        self.login = login
        self.userName = userName
        self.avatar = avatar
        self.status = status
        
    }
    
   
}

