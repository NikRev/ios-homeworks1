import UIKit
import FirebaseAuth




protocol LoginViewControllerDelegate: AnyObject {
    func checkCredentials(email: String, password: String, completion: @escaping (Bool, String?) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Bool, String?) -> Void)
}

protocol CheckerServiceProtocol{
    func signUp(email:String,password:String,complition: @escaping (Bool, String?)->Void)
    func checkCredentials(email:String,password:String,complition: @escaping (Bool, String?)->Void)
    
}


final class Checker:CheckerServiceProtocol {
    private func isValidEmail(_ email: String) -> Bool {
           return email.contains("@") && email.contains(".")
       }

    private func isValidPassword(_ password: String) -> Bool {
           return password.count >= 6  // For example, require a minimum of 6 characters
       }
    
    func checkCredentials(email: String, password: String, complition completion: @escaping (Bool, String?) -> Void) {
           Auth.auth().signIn(withEmail: email, password: password) { result, error in
               if let error = error {
                   completion(false, error.localizedDescription)
                   return
               }

               if let _ = result {
                   completion(true, nil)
               }
           }
       }

    func signUp(email: String, password: String, complition completion: @escaping (Bool, String?) -> Void) {
           Auth.auth().createUser(withEmail: email, password: password) { result, error in
               if let error = error {
                   completion(false, error.localizedDescription)
                   return
               }

               if let _ = result {
                   completion(true, nil)
               }
           }
       }
       enum AuthError: Error {
           case invalidCredentials
       }
}

