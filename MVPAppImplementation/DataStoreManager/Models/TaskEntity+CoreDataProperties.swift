//
//  TaskEntity+CoreDataProperties.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 01.03.2022.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var color: Data?
    @NSManaged public var currentDate: Date?
    @NSManaged public var descriptionText: String?
    @NSManaged public var fontText: String?
    @NSManaged public var image: Data?
    @NSManaged public var title: String?

}

extension TaskEntity : Identifiable {

}
