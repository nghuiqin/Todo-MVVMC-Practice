//
//  Board+CoreDataClass.swift
//  TodoMVVM-C
//
//  Created by Hui Qin Ng on 2019/5/10.
//
//

import Foundation
import CoreData

@objc(Board)
public class Board: NSManagedObject {
    public override func awakeFromInsert() {
        createdAt = NSDate()
    }
}
