//
//  TaskEntity.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

class TaskEntity: NSObject, NSCoding {
    
    var taskTitle: String = "taskTitle"
    var image: UIImage?
    
    private enum UserSettings {
        static let taskTitle = "taskTitle"
        static let image = "image"
    }
    
    init(title: String, image: UIImage?) {
        self.taskTitle = title
        self.image = image
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(taskTitle, forKey: UserSettings.taskTitle)
        coder.encode(image, forKey: UserSettings.image)
    }
    
    required init?(coder: NSCoder) {
        taskTitle = coder.decodeObject(forKey: UserSettings.taskTitle) as? String ?? ""
        image = coder.decodeObject(forKey: UserSettings.image) as? UIImage ?? #imageLiteral(resourceName: "imagePlaceholder")
    }
}
