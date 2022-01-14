//
//  TaskSettings.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 11.01.2022.
//

import UIKit

final class TaskSettings {
//    static let shared = TaskSettings()
    
    private enum SettingsKey {
        static let taskTitle = "taskTitle"
//        case taskEntity
    }
    
    //    var tasks: [TaskEntity] {
    //        get {
    //            let defaults = UserDefaults.standard
    //            let key = SettingsKey.taskTitle.rawValue
    //            if let data = defaults.value(forKey: key) as? Data {
    //                return try! PropertyListDecoder().decode([TaskEntity].self, from: data)
    //            } else {
    //                return [TaskEntity]()
    //            }
    //        } set {
    //            let defaults = UserDefaults.standard
    //            let key = SettingsKey.taskTitle.rawValue
    //            if let data = try? PropertyListEncoder().encode(newValue) {
    //                defaults.set(data, forKey: key)
    //            } else {
    //                defaults.removeObject(forKey: key)
    //            }
    //        }
    //    }
    
    var tasks: [TaskEntity]! {
        get {
            guard let data = UserDefaults.standard.object(forKey: SettingsKey.taskTitle) as? Data,
                  let decodeModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [TaskEntity] else { return [TaskEntity(title: "", image: nil)] }
            return decodeModel
        } set {
            let defaults = UserDefaults.standard
            
            if let model = newValue {
                if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false) {
                    defaults.set(saveData, forKey: SettingsKey.taskTitle)
                }
            }
        }
    }
//    func saveTask(title: String) {
//        let task = TaskEntity(title: title)
//        tasks.append(task)
//    }
}


























