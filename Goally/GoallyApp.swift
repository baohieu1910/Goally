//
//  GoallyApp.swift
//  Goally
//
//  Created by Hieu Le on 12/29/23.
//

import SwiftUI

@main
struct GoallyApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}
