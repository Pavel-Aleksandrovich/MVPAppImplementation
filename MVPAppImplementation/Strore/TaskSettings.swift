//
//  TaskSettings.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 11.01.2022.
//

import Foundation

protocol TaskSettings {
    var tasks: [TaskEntity]! { get set }
}

final class TaskSettingsImpl: TaskSettings {
    
    private enum SettingsKey {
        static let taskEntity = "taskEntity"
    }
    
    var tasks: [TaskEntity]! {
        get {
            guard let data = UserDefaults.standard.object(forKey: SettingsKey.taskEntity) as? Data,
                  let decodeModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [TaskEntity] else { return [TaskEntity(title: "nil", image: nil)] }
            return decodeModel
        } set {
            if let model = newValue {
                if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false) {
                    UserDefaults.standard.set(saveData, forKey: SettingsKey.taskEntity)
                }
            }
        }
    }
}


























