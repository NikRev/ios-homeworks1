import UIKit
import Foundation

protocol LoginFactory{
    func makeLoginInspector()->LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
