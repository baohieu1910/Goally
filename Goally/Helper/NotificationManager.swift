//
//  NotificationManager.swift
//  Goally
//
//  Created by Hieu Le on 12/30/23.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuth() {
        let option: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: option) { success, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success")
            }
        }

    }
}
