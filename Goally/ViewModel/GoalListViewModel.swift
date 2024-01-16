//
//  GoalListViewModel.swift
//  Goally
//
//  Created by Hieu Le on 12/30/23.
//

import Foundation
import CoreData

class GoalListViewModel: ObservableObject {
    
    @Published var goals: [Goals] = []
    private var taskListViewModel = TaskListViewModel()
    
    func getAllGoals() {
        goals = CoreDataManager.shared.getAllGoals()
    }
    
    func addGoal(title: String, desc: String) {
        let newGoal = Goals(context: CoreDataManager.shared.viewContext)
        
        newGoal.goalID = UUID()
        newGoal.title = title
        newGoal.desc = desc
        newGoal.progress = 0
        newGoal.isAchieved = false
        newGoal.timestamp = Date()
        
        CoreDataManager.shared.saveContext()
        getAllGoals()
    }
    
    func updateGoal() {
        CoreDataManager.shared.saveContext()
        getAllGoals()
    }
    
    func deleteGoal(goal: Goals) {
        for task in goal.tasksArray {
            NotificationManager.instance.removeNotification(taskID: task.unwrappedTaskId)
        }
        CoreDataManager.shared.deleteGoals(goal: goal)
        getAllGoals()
    }
    
    func calculateProgress(goal: Goals) {
        if goal.tasksArray.count != 0 {
            let totalTask = goal.tasksArray.count
            let totalAchieved = taskListViewModel.getTotalAchievedTask(goal: goal)
            
            goal.progress = Int16((totalAchieved*100) / totalTask)
            CoreDataManager.shared.saveContext()
            getAllGoals()
        }
    }
}
