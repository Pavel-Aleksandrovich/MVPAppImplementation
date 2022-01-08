//
//  AddTaskViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

class AddTaskViewController: UIViewController {
    var presenter: AddTaskPresenter!
    private let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewBackgrounColor()
        presenter.setViewTitle()
        
        view.addSubview(textField)
        textField.center = view.center
        textField.placeholder = "Enter the text"
        textField.backgroundColor = .green
    }
}

extension AddTaskViewController: addTaskView {
    func setViewBackgrounColor(color: UIColor?) {
        view.backgroundColor = color
    }
    
    func setViewTitle(title: String?) {
        self.title = title
    }
    
    
}
