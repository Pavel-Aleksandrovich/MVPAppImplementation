//
//  FontPicker.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 21.02.2022.
//

import UIKit

final class FontPicker: NSObject {
    
    private let pickerView = UIPickerView()
    private let textField: UITextField
    private weak var viewController: UIViewController?
    private let complitionHandler: (String) -> ()
    
    private let fonts = ["Kailasa", "Marker Felt", "Snell Roundhand", "Times New Roman",
                         "Rockwell", "Noteworthy Light", "Kefa Regular"]
    
    init(viewController: UIViewController, textField: UITextField,
         complitionHandler: @escaping (String) -> ()) {
        self.viewController = viewController
        self.textField = textField
        self.complitionHandler = complitionHandler
        super.init()
        configure()
    }
    
    private func configure() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        textField.inputView = pickerView
    }
}

extension FontPicker: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fonts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fonts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = fonts[row]
        complitionHandler(fonts[row])
        viewController?.view.endEditing(true)
    }
}
