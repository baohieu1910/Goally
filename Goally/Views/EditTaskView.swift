//
//  EditTaskView.swift
//  Goally
//
//  Created by Hieu Le on 1/1/24.
//

import SwiftUI

struct EditTaskView: View {
    @Binding var showEditTask: Bool
    @Binding var task: Tasks
    
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    TextField("Input the title", text: $task.title.toUnwrapped(defaultValue: "Test"))
                } header: {
                    Text("Task Title")
                        .offset(x: -20)
                }
                
                Section {
                    DatePicker(selection: $task.reminderTime.toUnwrapped(defaultValue: Date()), label: {Text("Date")})
                            .datePickerStyle(GraphicalDatePickerStyle())
                } header: {
                    Text("Reminder")
                        .offset(x: -20)
                }
            }
            .navigationBarTitle(Text("Edit Task"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.showEditTask.toggle()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        taskListViewModel.editTask(task: task)
                        self.showEditTask.toggle()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(showEditTask: .constant(true), task: .constant(Tasks(context: CoreDataManager.shared.viewContext)))
    }
}
