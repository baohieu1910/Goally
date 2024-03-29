//
//  Goals+CoreDataProperties.swift
//  Goally
//
//  Created by Hieu Le on 12/30/23.
//
//

import Foundation
import CoreData


extension Goals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goals> {
        return NSFetchRequest<Goals>(entityName: "Goals")
    }

    @NSManaged public var desc: String?
    @NSManaged public var goalID: UUID?
    @NSManaged public var isAchieved: Bool
    @NSManaged public var progress: Int16
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var tasks: NSSet?

    public var unwrappedTitle: String {
        return title ?? ""
    }

    public var unwrappedProgress: Int16 {
        return progress
    }

    public var unwrappedDesc: String {
        return desc ?? ""
    }

    public var unwrappedIsAchieved: Bool {
        return isAchieved
    }

    public var tasksArray: [Tasks] {
        let tasksSet = tasks as? Set<Tasks> ?? []

        return tasksSet.sorted {
            $0.timestamp! < $1.timestamp!
        }
    }
}

// MARK: Generated accessors for tasks
extension Goals {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Tasks)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Tasks)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension Goals : Identifiable {

}
