//
//  CoreDataManager.swift
//  Goally
//
//  Created by Hieu Le on 12/29/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "GoallyDataModel")
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getAllGoals() -> [Goals]{
        let request = NSFetchRequest<Goals>(entityName: "Goals")
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func addGoal(emoji: String, title: String, desc: String) {
        let newGoal = Goals(context: viewContext)
        
        newGoal.goalID = UUID()
        newGoal.emoji = emoji
        newGoal.title = title
        newGoal.desc = desc
        newGoal.progress = 0
        newGoal.isAchieved = false
        newGoal.timestamp = Date()
        
        saveContext()
    }
    
    func deleteGoals(goal: Goals) {
        viewContext.delete(goal)
        saveContext()
    }
    
    func getAllTasks() -> [Tasks] {
        let request = NSFetchRequest<Tasks>(entityName: "Tasks")
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func deleteTasks(task: Tasks) {
        viewContext.delete(task)

        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
