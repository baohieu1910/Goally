//
//  AddGoalView.swift
//  Goally
//
//  Created by Hieu Le on 1/1/24.
//

import SwiftUI

struct AddGoalView: View {
    @Binding var showModal: Bool
    @State var title: String = ""
    @State var description: String = ""
    @State var stateAction: String = ""
    
    @EnvironmentObject private var goalListViewModel: GoalListViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input the goal title", text: $title)
                        .lineLimit(1)
                } header: {
                    Text("Goal Title")
                        .offset(x: -20)
                }
                
                Section {
                    TextField("Input the goal description", text: $description)
                        .lineLimit(2)
                } header: {
                    Text("Goal Description")
                        .offset(x: -20)
                }
            }
            .navigationBarTitle(Text("Add Goal"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.showModal.toggle()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(.systemBlue))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        goalListViewModel.addGoal(title: title, desc: description)
                        self.showModal.toggle()
                    } label: {
                        Text("Add")
                            .foregroundColor(Color(.systemBlue))
                    }
                }
            }
        }
    }
}

struct AddGoalView_Previews: PreviewProvider {
    static var previews: some View {
        AddGoalView(showModal: .constant(true))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
