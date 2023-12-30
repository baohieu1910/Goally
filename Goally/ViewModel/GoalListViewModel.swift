//
//  GoalListViewModel.swift
//  Goally
//
//  Created by Hieu Le on 12/30/23.
//

import Foundation
import CoreData

class GoalListViewModel {
    
    @Published var goals: [Goals] = []
    private var taskListViewModel = TaskListViewModel()
    
    func getAllGoals() {
        goals = CoreDataManager.shared.getAllGoals()
    }
    
    func addGoals(emoji: String, title: String, desc: String) {
        let newGoal = Goals(context: CoreDataManager.shared.viewContext)
        
        newGoal.goalID = UUID()
        newGoal.emoji = emoji
        newGoal.title = title
        newGoal.desc = desc
        newGoal.progress = 0
        newGoal.isAchieved = false
        newGoal.timestamp = Date()
        
        CoreDataManager.shared.saveContext()
        getAllGoals()
    }
    
    func updateGoals() {
        CoreDataManager.shared.saveContext()
        getAllGoals()
    }
    
    func deleteGoals(goal: Goals) {
        for task in goal.tasksArray {
//            Notification
        }
        CoreDataManager.shared.deleteGoals(goal: goal)
        getAllGoals()
    }
    
    func calculateProgress(goal: Goals) {
        if goal.tasksArray.count != 0 {
            let todoTask = goal.tasksArray.count
//            let totalAchieved = 
        }
    }
}
