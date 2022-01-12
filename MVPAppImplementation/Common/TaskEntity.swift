//
//  TaskEntity.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import Foundation

class TaskEntity: NSObject, Codable{
    
    var taskTitle: String
    
    init(title: String) {
        self.taskTitle = title
    }
}
