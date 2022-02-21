//
//  FontPicker.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 21.02.2022.
//

import UIKit

final class FontPicker: NSObject {
    
    private let pickerView = UIPickerView()
    private let toolbar = UIToolbar()
    private var font: String?
    private var size: CGFloat?
    private let textField: UITextField
    private weak var viewController: UIViewController?
    private let complitionHandler: (String, CGFloat) -> ()
    
    private let fonts = ["Kailasa", "Marker Felt", "Snell Roundhand", "Times New Roman",
                         "Rockwell", "Noteworthy Light", "Kefa Regular"]
    private let sizes: [CGFloat] = [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]
    
    init(viewController: UIViewController, textField: UITextField,
         complitionHandler: @escaping (String, CGFloat) -> ()) {
        self.viewController = viewController
        self.textField = textField
        self.complitionHandler = complitionHandler
        super.init()
        configureAppearance()
        configureToolbar()
    }
    
    private func configureAppearance() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        textField.inputAccessoryView = toolbar
        textField.inputView = pickerView
    }
    
    private func configureToolbar() {
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        toolbar.sizeToFit()
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
    }
    
    @objc private func doneButtonTapped() {
        guard let font = font, let size = size else { return }
        complitionHandler(font, size)
        viewController?.view.endEditing(true)
    }
    
    @objc private func cancelButtonTapped() {
        viewController?.view.endEditing(true)
    }
}

extension FontPicker: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return fonts.count
        case 1:
            return sizes.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return fonts[row]
        } else {
            return "\(sizes[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            font = fonts[row]
        } else {
            size = sizes[row]
        }
    }
}
