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
    
    private enum SettingsKey {
        static let taskTitle = "taskTitle"
        static let image = "image"
    }
    
    init(title: String?, image: UIImage?) {
        self.taskTitle = title
        self.image = image
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(taskTitle, forKey: SettingsKey.taskTitle)
        coder.encode(image, forKey: SettingsKey.image)
    }
    
    required init?(coder: NSCoder) {
        taskTitle = coder.decodeObject(forKey: SettingsKey.taskTitle) as? String ?? "nil"
        image = coder.decodeObject(forKey: SettingsKey.image) as? UIImage ?? #imageLiteral(resourceName: "DefaultProfileImage")
    }
}
