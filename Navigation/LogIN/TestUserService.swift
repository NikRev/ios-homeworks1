import UIKit

class TestUserService: UserService {
    let user = Users.test.instance
    func authenticateUser(login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }
    
   
    
    
}
