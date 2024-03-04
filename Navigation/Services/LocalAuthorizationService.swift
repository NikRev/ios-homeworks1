import UIKit
import LocalAuthentication

class LocalAuthorizationService {
    // Контекст LocalAuthentication
    let laContext = LAContext()
    
    // Замыкание для обработки результата аутентификации
    typealias AuthorizationCompletion = (Bool, Error?) -> Void

    func authorizeIfPossible(completion: @escaping AuthorizationCompletion) {
        laContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics, localizedReason: "Для доступа к данным"
        ) { success, error in
            if let error = error {
                print("Ошибка при аутентификации: \(error.localizedDescription)")
                completion(false, error)
                return
            }
            print("Аутентификация успешна: \(success)")
            completion(success, nil)
        }
    }
}
