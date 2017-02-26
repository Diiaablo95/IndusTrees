//
//  NotificationManager.swift
//  MindTheMap
//
//  Created by Antonio Antonino on 25/02/2017.
//  Copyright © 2017 A16. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject {
    
    static let shared = NotificationManager()
    
    private struct NotificationKeys {
        static let ID_KEY = "id"
    }
    
    struct NotificationValues {
        static let TASK_ADDED = "NewTask"
        static let TASK_COMPLETED = "TaskCompleted"
        static let TASK_VALIDATED = "TaskValidated"
        static let PRESENCE_REGISTERED = "NewPresence"
    }
    
    private let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
    
    private override init() {}
    
    func setup() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: { result, error in
            print("Result for notifications permission request: \(result)")
            if result {
                UNUserNotificationCenter.current().delegate = self
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        })
    }
    
    func scheduleNotificationForTaskAdded(withUserId userId: UInt16) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "A new task has assigned to you!"
        notificationContent.body = "Open IndusTrees to get more details."
        notificationContent.sound = UNNotificationSound.default()
        
        notificationContent.userInfo = [NotificationManager.NotificationKeys.ID_KEY: userId]
        
        let notificationRequest = UNNotificationRequest(identifier: NotificationManager.NotificationValues.TASK_ADDED, content: notificationContent, trigger: self.notificationTrigger)
        
        UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
        print("Notification scheduled for a task added!")
    }
    
    func scheduleNotificationForTaskCompleted(withTaskId taskId: UInt16) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "A new task has been completed!"
        notificationContent.body = "Open IndusTrees to check and validate it."
        notificationContent.sound = UNNotificationSound.default()
        
        notificationContent.userInfo = [NotificationManager.NotificationKeys.ID_KEY: taskId]
        
        let notificationRequest = UNNotificationRequest(identifier: NotificationManager.NotificationValues.TASK_COMPLETED, content: notificationContent, trigger: self.notificationTrigger)
        
        UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
        print("Notification scheduled for a task completed!")
    }
    
    func scheduleNotificatonForTaskValidated(withTaskId taskId: UInt16) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "A new task has been validated!"
        notificationContent.body = "Open IndusTrees to check your status."
        notificationContent.sound = UNNotificationSound.default()
        
        notificationContent.userInfo = [NotificationManager.NotificationKeys.ID_KEY: taskId]
        
        let notificationRequest = UNNotificationRequest(identifier: NotificationManager.NotificationValues.TASK_VALIDATED, content: notificationContent, trigger: self.notificationTrigger)
        
        UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
        print("Notification scheduled for a task validated!")
    }
    
    func scheduleNotificatonForPresenceToRegister(forUserWithId userId: UInt16) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "A new employeed just got to work!"
        let account = DataStore.account(with: userId)!
        notificationContent.body = "\(account.name) \(account.surname) just entered the office!"
        notificationContent.sound = UNNotificationSound.default()
        
        notificationContent.userInfo = [NotificationManager.NotificationKeys.ID_KEY: userId]
        
        let notificationRequest = UNNotificationRequest(identifier: NotificationManager.NotificationValues.PRESENCE_REGISTERED, content: notificationContent, trigger: self.notificationTrigger)
        
        UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
        print("Notification scheduled for a task validated!")
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if let response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Showing notification: \(notification)")
        completionHandler([.alert, .sound])
    }
}
