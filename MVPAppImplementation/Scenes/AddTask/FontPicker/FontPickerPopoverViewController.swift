//
//  FontPickerPopoverViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 20.01.2022.
//

import UIKit

protocol FontPickerPopoverDelegate: AnyObject {
    func setFont(font: String)
}

class FontPickerPopoverViewController: UIViewController {
    
    weak var delegate: FontPickerPopoverDelegate?
    private let fontPicker = UIPickerView()
    private let fonts: [String] = ["Kailasa", "Marker Felt", "Snell Roundhand"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(fontPicker)
        fontPicker.center = view.center
        fontPicker.delegate = self
        fontPicker.dataSource = self
        fontPicker.frame = CGRect(x: 10, y: 10, width: 240, height: 120)
    }
}

extension FontPickerPopoverViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        fonts.count
    }
    
}

extension FontPickerPopoverViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let result = "\(fonts[row])"
        delegate?.setFont(font: result)
        return result
    }
}
