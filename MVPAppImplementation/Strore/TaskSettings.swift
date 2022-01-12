//
//  TaskSettings.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 11.01.2022.
//

import Foundation

final class TaskSettings {
    static let shared = TaskSettings()
    
    private enum SettingsKey: String {
        case taskTitle
    }
    
    var tasks: [TaskEntity] {
        get {
            let defaults = UserDefaults.standard
            let key = SettingsKey.taskTitle.rawValue
            if let data = defaults.value(forKey: key) as? Data {
                return try! PropertyListDecoder().decode([TaskEntity].self, from: data)
            } else {
                return [TaskEntity]()
            }
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKey.taskTitle.rawValue
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    func saveTask(title: String) {
        let task = TaskEntity(title: title)
        tasks.insert(task, at: 0)
    }
}



























