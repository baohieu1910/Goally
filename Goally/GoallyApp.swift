//
//  GoallyApp.swift
//  Goally
//
//  Created by Hieu Le on 12/29/23.
//

import SwiftUI

@main
struct GoallyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
