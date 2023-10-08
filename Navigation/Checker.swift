import UIKit

protocol LoginViewControllerDelegate{
    func check(login:Int,password:Int)->Bool
}


final class Checker {

    private let login: Int = 1234
    private let password: Int = 1234

    
    static let shared = Checker()

    private init() {}

    func check(login: Int, password: Int) -> Bool {
        return self.login == login && self.password == password
    }
}

