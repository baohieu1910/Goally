//
//  TaskListViewModel.swift
//  Goally
//
//  Created by Hieu Le on 12/30/23.
//

import Foundation
import CoreData

class TaskListViewModel {
    @Published var tasks: [Task] = []
    
    func getAllTasks() {
        tasks = CoreDataManager.shared.getAllGoals()
    }
}
