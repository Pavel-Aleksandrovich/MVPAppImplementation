//
//  AddTaskViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

class AddTaskViewController: UIViewController {
    var presenter: AddTaskPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewBackgrounColor()
        presenter.setViewTitle()
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
