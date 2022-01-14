//
//  TaskSettings.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 11.01.2022.
//

import UIKit

protocol TaskSettings {
    var tasks: [TaskEntity]! { get set }
}

final class TaskSettingsImpl: TaskSettings {
    
    private enum SettingsKey {
        static let taskTitle = "taskTitle"
    }
    
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
}


























