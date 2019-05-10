//
//  Task+CoreDataProperties.swift
//  TodoMVVM-C
//
//  Created by Hui Qin Ng on 2019/5/10.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var board: Board?

}
