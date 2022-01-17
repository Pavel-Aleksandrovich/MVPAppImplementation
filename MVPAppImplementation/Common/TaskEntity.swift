//
//  TaskEntity.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

class TaskEntity: NSObject, NSCoding {
    
    var titleText: String?
    var descriptionText: String?
    var image: UIImage?
    var currentDate: String?
    
    private enum SettingsKey {
        static let taskTitle = "taskTitle"
        static let image = "image"
        static let currentDate = "currentDate"
        static let descriptionText = "descriptionText"
    }
    
    init(title: String?, image: UIImage?, currentDate: String?, descriptionText: String?) {
        self.titleText = title
        self.image = image
        self.currentDate = currentDate
        self.descriptionText = descriptionText
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(titleText, forKey: SettingsKey.taskTitle)
        coder.encode(image, forKey: SettingsKey.image)
        coder.encode(currentDate, forKey: SettingsKey.currentDate)
        coder.encode(descriptionText, forKey: SettingsKey.descriptionText)
    }
    
    required init?(coder: NSCoder) {
        titleText = coder.decodeObject(forKey: SettingsKey.taskTitle) as? String ?? "nil"
        image = coder.decodeObject(forKey: SettingsKey.image) as? UIImage ?? #imageLiteral(resourceName: "DefaultProfileImage")
        currentDate = coder.decodeObject(forKey: SettingsKey.currentDate) as? String ?? "nil"
        descriptionText = coder.decodeObject(forKey: SettingsKey.descriptionText) as? String ?? "nil"
    }
}
