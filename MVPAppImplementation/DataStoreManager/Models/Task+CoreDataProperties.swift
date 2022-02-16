//
//  Task+CoreDataProperties.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 15.02.2022.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?

}

extension Task : Identifiable {

}
