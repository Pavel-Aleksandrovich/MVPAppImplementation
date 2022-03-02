//
//  TaskService.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 01.03.2022.
//

import Foundation
import CoreData

protocol TaskService {
    func createTask(sourceTask: Task)
    func updateTask(sourceTask: Task, task: TaskEntity)
    func getTasks() -> [TaskEntity]
    func getTaskBy(id: NSManagedObjectID) -> TaskEntity?
    func getNumberOfTasks() -> Int
    func deleteTaskBy(id: NSManagedObjectID)
}

final class TaskServiceImpl: TaskService {
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    func createTask(sourceTask: Task) {
        let task = TaskEntity(context: coreDataManager.context)
        task.title = sourceTask.title
        task.descriptionText = sourceTask.descriptionText
        task.currentDate = sourceTask.currentDate
        let imageData = sourceTask.image.pngData()
        task.image = imageData
        
        coreDataManager.saveContext()
    }
    
    func updateTask(sourceTask: Task, task: TaskEntity) {
        task.title = sourceTask.title
        task.descriptionText = sourceTask.descriptionText
        task.currentDate = sourceTask.currentDate
        let imageData = sourceTask.image.pngData()
        task.image = imageData
        
        coreDataManager.saveContext()
    }
    
    func getTasks() -> [TaskEntity] {
        return coreDataManager.getAll()
    }
    
    func getTaskBy(id: NSManagedObjectID) -> TaskEntity? {
        return coreDataManager.getBy(id: id)
    }
    
    func getNumberOfTasks() -> Int {
        return getTasks().count
    }
    
    func deleteTaskBy(id: NSManagedObjectID) {
        let task = getTaskBy(id: id)
        if task != nil {
            coreDataManager.context.delete(task!)
            coreDataManager.saveContext()
        }
    }
    
}
