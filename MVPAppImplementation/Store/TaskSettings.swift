//
//  TaskSettings.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 11.01.2022.
//

import Foundation

protocol TaskSettings {
    func saveTask(task: TaskEntity)
    func removeTask(index: Int)
    func numberOfTasks() -> Int
    func getTaskByIndex(index: Int) -> TaskEntity
    func updateTaskByIndex(task: TaskEntity, index: Int)
}

final class TaskSettingsImpl: TaskSettings {
    
    private enum SettingsKey {
        static let taskEntity = "taskEntity"
    }
    
    private var tasks: [TaskEntity]! {
        get {
            guard let data = UserDefaults.standard.object(forKey: SettingsKey.taskEntity) as? Data,
                  let decodeModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [TaskEntity] else { return [TaskEntity(title: "nil", image: #imageLiteral(resourceName: "DefaultProfileImage"), currentDate: "", descriptionText: "", color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), date: "")] }
            return decodeModel
        } set {
            if let model = newValue {
                if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false) {
                    UserDefaults.standard.set(saveData, forKey: SettingsKey.taskEntity)
                }
            }
        }
    }
    
    func saveTask(task: TaskEntity) {
        tasks.insert(task, at: 0)
    }
    
    func removeTask(index: Int) {
        tasks.remove(at: index)
    }
    
    func numberOfTasks() -> Int {
        return tasks.count
    }
    
    func getTaskByIndex(index: Int) -> TaskEntity {
        return tasks[index]
    }
    
    func updateTaskByIndex(task: TaskEntity, index: Int) {
        tasks.remove(at: index)
        tasks.insert(task, at: index)
    }
}


























