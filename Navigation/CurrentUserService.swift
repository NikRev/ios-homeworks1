import UIKit


class CurrentUserService: UserService {
    let user = Users.main.instance
    func authenticateUser(login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }
    
    
    
    
}
