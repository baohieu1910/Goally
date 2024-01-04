//
//  AddTaskView.swift
//  Goally
//
//  Created by Hieu Le on 1/1/24.
//

import SwiftUI

struct AddTaskView: View {
    @Binding var showAddTask: Bool
    
    @State var title: String = ""
    @State var selectedDate = Date()
    @StateObject var goals: Goals
    
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    TextField("Input the title", text: $title)
                } header: {
                    Text("Task Title")
                        .offset(x: -20)
                }
                
                Section {
                    DatePicker("Date" ,selection: $selectedDate)
                        .datePickerStyle(GraphicalDatePickerStyle())
                } header: {
                    Text("Date Reminder")
                        .offset(x: -20)
                }
            }
            .navigationBarTitle(Text("Add Task"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.showAddTask.toggle()
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        taskListViewModel.addTask(goal: goals, title: title, reminderTime: selectedDate)
                        self.showAddTask.toggle()
                    } label: {
                        Text("Add")
                    }
                }
            }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(showAddTask: .constant(true), goals: Goals(context: CoreDataManager.shared.viewContext))
    }
}
