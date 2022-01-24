//
//  UITextField Extension.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 24.01.2022.
//

import UIKit

extension UITextField {
    var textOrEmptyString: String {
        return text ?? ""
    }
}

extension UITextView {
    var textOrEmptyString: String {
        return text ?? ""
    }
}

extension UIImageView {
    var textOrEmptyString: UIImage {
        return image ?? #imageLiteral(resourceName: "DefaultProfileImage.png")
    }
}

extension UIButton {
    var textOrEmptyString: UIColor {
        return backgroundColor ?? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
extension Date {
    func relativeDescription(referenceDate: Date = Date()) -> String {
        return "Long time ago"
    }
}
