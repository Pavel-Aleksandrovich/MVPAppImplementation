//
//  TaskEntity.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

class TaskEntity: NSObject, NSCoding {
    
    var taskTitle: String?
    var image: UIImage?
    var currentDate: String?
    
    private enum SettingsKey {
        static let taskTitle = "taskTitle"
        static let image = "image"
        static let currentDate = "currentDate"
    }
    
    init(title: String?, image: UIImage?, currentDate: String?) {
        self.taskTitle = title
        self.image = image
        self.currentDate = currentDate
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(taskTitle, forKey: SettingsKey.taskTitle)
        coder.encode(image, forKey: SettingsKey.image)
        coder.encode(currentDate, forKey: SettingsKey.currentDate)
    }
    
    required init?(coder: NSCoder) {
        taskTitle = coder.decodeObject(forKey: SettingsKey.taskTitle) as? String ?? "nil"
        image = coder.decodeObject(forKey: SettingsKey.image) as? UIImage ?? #imageLiteral(resourceName: "DefaultProfileImage")
        currentDate = coder.decodeObject(forKey: SettingsKey.currentDate) as? String ?? "nil"
    }
}
