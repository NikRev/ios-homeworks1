import UIKit
import Foundation



struct LoginInspector {
    private let checkerService: CheckerServiceProtocol

    init(checkerService: CheckerServiceProtocol) {
        self.checkerService = checkerService
    }

    func performLogin(email: String, password: String) {
        checkerService.checkCredentials(email: email, password: password) { success, error in
            if success {
                print("success")
            } else {
               print("failure")
            }
        }
    }

    func performSignUp(email: String, password: String) {
        checkerService.signUp(email: email, password: password) { success, error in
            if success {
                print("success")
            } else {
                print("failure")
            }
        }
    }
}
