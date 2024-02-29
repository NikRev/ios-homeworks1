import UIKit

import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let localNotificationsService = LocalNotificationsService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           
          

           // Use Task to call the asynchronous method
           Task {
               do {
                   try await self.localNotificationsService.registeForLatestUpdatesIfPossible()
               } catch {
                   // Handle errors
                   print("Error registering for latest updates: \(error)")
               }
           }

           // Example: Make a network request for people
           let randomConfiguration: AppConfiguration = [.people, .planets, .starships].randomElement() ?? .people

           // Example: Make a network request with a random configuration
           NetworkService.request(for: randomConfiguration) { result in
               switch result {
               case .success(let data):
                   // Handle the success case, you can parse and use the data here
                   print("Successfully received data for \(randomConfiguration):", data)
               case .failure(let error):
                   // Handle the failure case, you can display an error message or log the error
                   print("Network request failed with error:", error.localizedDescription)
               }
           }

           return true
       }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
      
    }

}
