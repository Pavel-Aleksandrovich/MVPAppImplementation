//
//  DatePickerPopoverViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 21.01.2022.
//

import UIKit

protocol DatePickerPopoverDelegate: AnyObject {
}

class DatePickerPopoverViewController: UIViewController {
    
    weak var delegate: DatePickerPopoverDelegate?
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(datePicker)
        datePicker.center = view.center
        datePicker.datePickerMode = .dateAndTime
        datePicker.backgroundColor = .gray
    }
}
