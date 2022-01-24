//
//  TaskEntity.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

class TaskEntity: NSObject, NSCoding {
    
    let titleText: String
    let descriptionText: String
    let image: UIImage
    let currentDate: String
    let color: UIColor
    let date: String
    
    private enum SettingsKey {
        static let taskTitle = "taskTitle"
        static let image = "image"
        static let currentDate = "currentDate"
        static let descriptionText = "descriptionText"
        static let color = "color"
        static let date = "date"
    }
    
    init(title: String, image: UIImage, currentDate: String, descriptionText: String, color: UIColor, date: String) {
        self.titleText = title
        self.image = image
        self.currentDate = currentDate
        self.descriptionText = descriptionText
        self.color = color
        self.date = date
    }
    
    required init?(coder: NSCoder) {
        titleText = coder.decodeObject(forKey: SettingsKey.taskTitle) as? String ?? "nil"
        image = coder.decodeObject(forKey: SettingsKey.image) as? UIImage ?? #imageLiteral(resourceName: "DefaultProfileImage")
        currentDate = coder.decodeObject(forKey: SettingsKey.currentDate) as? String ?? "nil"
        descriptionText = coder.decodeObject(forKey: SettingsKey.descriptionText) as? String ?? "nil"
        color = coder.decodeObject(forKey: SettingsKey.color) as? UIColor ?? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        date = coder.decodeObject(forKey: SettingsKey.date) as? String ?? "nil"
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(titleText, forKey: SettingsKey.taskTitle)
        coder.encode(image, forKey: SettingsKey.image)
        coder.encode(currentDate, forKey: SettingsKey.currentDate)
        coder.encode(descriptionText, forKey: SettingsKey.descriptionText)
        coder.encode(color, forKey: SettingsKey.color)
        coder.encode(date, forKey: SettingsKey.date)
    }
}
