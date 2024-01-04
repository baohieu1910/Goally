//
//  TaskListViewModel.swift
//  Goally
//
//  Created by Hieu Le on 12/30/23.
//

import Foundation
import CoreData

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Tasks] = []
    
    func getAllTasks() {
        tasks = CoreDataManager.shared.getAllTasks()
    }
    
    func addTask(goal: Goals, title: String, reminderTime: Date) {
        let newTask = Tasks(context: CoreDataManager.shared.viewContext)
        
        newTask.taskID = UUID()
        newTask.title = title
        newTask.reminderTime = reminderTime
        newTask.isAchieved = false
        newTask.timestamp = Date()
        
        goal.addToTasks(newTask)
        NotificationManager.instance.scheduleNotification(task: newTask)
        
        CoreDataManager.shared.saveContext()
        getAllTasks()
    }
    
    func updateTask() {
        CoreDataManager.shared.saveContext()
        getAllTasks()
    }
    
    func editTask(task: Tasks) {
        NotificationManager.instance.scheduleNotification(task: task)
        CoreDataManager.shared.saveContext()
        getAllTasks()
    }
    
    func deleteTask(task: Tasks) {
        NotificationManager.instance.removeNotification(taskID: task.unwrappedTaskId)
        
        CoreDataManager.shared.deleteTasks(task: task)
        getAllTasks()
    }
    
    func getTotalAchievedTask(goal: Goals) -> Int{
        var totalAchieved = 0
        
        for task in goal.tasksArray {
            if task.isAchieved {
                totalAchieved += 1
            }
        }
        
        return totalAchieved
    }
}
