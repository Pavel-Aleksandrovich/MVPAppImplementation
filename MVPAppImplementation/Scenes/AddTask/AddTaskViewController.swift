//
//  AddTaskViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

class AddTaskViewController: UIViewController {
    private var presenter: AddTaskPresenter!
    private let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    
    init(presenter: AddTaskPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(view: self)
        presenter.setViewBackgrounColor()
        presenter.setViewTitle()
        
        view.addSubview(textField)
        textField.center = view.center
        textField.placeholder = "Enter the text"
        textField.backgroundColor = .green
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed))
    }
    
    @objc private func saveButtonPressed() {
        let addTask = TaskEntity(title: textField.text!)
        presenter.addButtonPressed(parametrs: addTask)
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
