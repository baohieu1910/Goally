//
//  EditGoalView.swift
//  Goally
//
//  Created by Hieu Le on 1/1/24.
//

import SwiftUI

struct EditGoalView: View {
    @Binding var showEditGoalModal: Bool
    
    @State var title: String = ""
    @State var description: String = ""
    
    @Binding var goals: Goals
    @EnvironmentObject private var goalListViewModel: GoalListViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input the goal title", text: $goals.title.toUnwrapped(defaultValue: ""))
                        .lineLimit(1)
                } header: {
                    Text("Goal Title")
                        .offset(x: -20)
                }
                
                Section {
                    TextField("Input the goal description", text: $goals.desc.toUnwrapped(defaultValue: ""))
                        .lineLimit(2)
                } header: {
                    Text("Goal Description")
                        .offset(x: -20)
                }
            }
            .navigationBarTitle(Text("Edit Goal"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.showEditGoalModal.toggle()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(.systemBlue))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        goalListViewModel.updateGoal()
                        self.showEditGoalModal.toggle()
                    } label: {
                        Text("Edit")
                            .foregroundColor(Color(.systemBlue))
                    }
                }
            }
        }
    }
}

struct EditGoalView_Previews: PreviewProvider {
    static var previews: some View {
        EditGoalView(showEditGoalModal: .constant(true), goals: .constant(Goals()))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
