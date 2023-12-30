//
//  Tasks+CoreDataProperties.swift
//  Goally
//
//  Created by Hieu Le on 12/30/23.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var isAchieved: Bool
    @NSManaged public var reminderTime: Date?
    @NSManaged public var taskID: UUID?
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var goal: Goals?

    public var unwrappedTaskId: UUID {
        taskId ?? UUID()
    }
    
    public var unwrappedTitle: String {
        title ?? ""
    }

    public var unwrappedReminderTime: Date {
        reminderTime ?? Date()
    }

    public var unwrappedIsAchieved: Bool {
        isAchieved ?? false
    }
}

extension Tasks : Identifiable {

}
