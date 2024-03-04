import Foundation
import UserNotifications

class LocalNotificationsService {
    func request() async throws {
        try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
    }
    
    func authorization() async -> Bool {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        return settings.authorizationStatus == .authorized
    }
    
    func addNotification(title: String, text: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = text
        content.sound = .default
        content.categoryIdentifier = "MyCategory1"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotificationAll() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func removeNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func registerCategory() {
        let action = UNNotificationAction(identifier: "MyCategory1", title: "Button", options: [])
        
        let category = UNNotificationCategory(identifier: "MyCategory1", actions: [action], intentIdentifiers: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    func registeForLatestUpdatesIfPossible() async {
        do {
            try await request() // Request authorization
            
            if await authorization() {
                // Authorization granted
                let content = UNMutableNotificationContent()
                content.title = "Latest Updates"
                content.body = "Посмотрите последние обновления"
                content.sound = .default
                content.categoryIdentifier = "MyCategory1"
                
                var dateComponents = DateComponents()
                dateComponents.hour = 19
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                try await UNUserNotificationCenter.current().add(request)
            }
        } catch {
            // Handle errors
            print("Error requesting authorization: \(error)")
        }
    }
}
