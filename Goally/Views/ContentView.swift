//
//  ContentView.swift
//  Goally
//
//  Created by Hieu Le on 12/29/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        TabView {
            GoalView(selectedGoal: Goals())
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Text("Another")
                .tabItem {
                    Label("Another", systemImage: "pencil")
                }
        }
        .accentColor(Color(.systemBlue))
        .onAppear {
            NotificationManager.instance.requestAuth()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
