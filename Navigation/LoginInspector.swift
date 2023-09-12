import UIKit
import Foundation

struct LoginInspector:LoginViewControllerDelegate{
    func check(login: Int, password: Int) -> Bool {
        // Используем синглтон Checker для проверки логина и пароля
        return Checker.shared.check(login: 1234, password: 1234)
    }
}
