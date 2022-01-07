//
//  ViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

class TaskListViewController: UIViewController {

    var presenter: TaskListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setTitle()
    }
}

//MARK: - TaskListView
extension TaskListViewController: TaskListView {
    
    func setTitle(title: String?) {
        self.title = title
    }
    
}
