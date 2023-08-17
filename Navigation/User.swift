import UIKit

public protocol UserService {
    func authenticateUser(login: String) -> User?
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
