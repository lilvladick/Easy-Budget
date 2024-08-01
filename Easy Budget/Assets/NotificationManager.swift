import Foundation
import SwiftUI
import UserNotifications

class NotificationManager {
    func reqestNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func disableNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UIApplication.shared.unregisterForRemoteNotifications()
    }
    
    func scheduleNotifications(for operation: Operation) {
        let content = UNMutableNotificationContent()
        content.title = "East Budget"
        content.body = operation.name
        content.sound = UNNotificationSound.default
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day], from: operation.dateCreated)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
               
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
