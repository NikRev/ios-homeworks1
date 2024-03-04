import UIKit
import Foundation
import Firebase
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appConfiguration: AppConfiguration = .people // Инициализируйте значением по умолчанию

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Создайте массив со всеми случаями AppConfiguration
        let allCases: [AppConfiguration] = [.people, .planets, .starships]
        
        // Получите случайный индекс
        let randomIndex = Int.random(in: 0..<allCases.count)
        
        // Используйте случайный индекс для выбора случайного значения
        appConfiguration = allCases[randomIndex]

        let window = UIWindow(windowScene: windowScene)
       
       // _ = MyLoginFactory()
               
      
        let mainTabBArController = MainTabBarConroller()
        window.rootViewController = mainTabBArController
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
           // Вызов метода разлогинивания пользователя
           do {
               try Auth.auth().signOut()
           } catch let signOutError as NSError {
               print ("Error signing out: %@", signOutError)
           }
       }
}
