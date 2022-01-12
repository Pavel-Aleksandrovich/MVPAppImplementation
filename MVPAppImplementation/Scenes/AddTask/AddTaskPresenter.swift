//
//  AddTaskPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

protocol AddTaskPresenterDelegate: AnyObject {
    func addTaskPresenter(presenter: AddTaskPresenter, task: TaskEntity)
}

protocol AddTaskPresenter {
    func setViewBackgrounColor()
    func setViewTitle()
    func addButtonPressed(parametrs: TaskEntity)
    func onViewAttached(view: AddTaskView)
    func isEnabledSaveButton(textField: String) -> Bool
    func popViewController(view: AddTaskViewController)
}

protocol AddTaskView: AnyObject {
    func setViewBackgrounColor(color: UIColor?)
    func setViewTitle(title: String?)
    func isEnabled()
}

final class AddTaskPresenterImpl: AddTaskPresenter {
    private weak var view: AddTaskView?
    private var delegate: AddTaskPresenterDelegate
    private var router: AddTaskRouter
    
    init(router: AddTaskRouter, delegate: AddTaskPresenterDelegate) {
        self.router = router
        self.delegate = delegate
    }
    
    func isEnabledSaveButton(textField: String) -> Bool {
        if textField.isEmpty{
            return false
        } else {
            return true
        }
    }
    
    func onViewAttached(view: AddTaskView) {
        self.view = view
    }
    
    func setViewBackgrounColor() {
        view?.setViewBackgrounColor(color: .white.withAlphaComponent(0.9))
    }
    
    func setViewTitle() {
        view?.setViewTitle(title: "Add Task")
    }
    
    func addButtonPressed(parametrs: TaskEntity) {
        delegate.addTaskPresenter(presenter: self, task: parametrs)
    }
    
    func popViewController(view: AddTaskViewController) {
        router.popViewController(view: view, animated: false)
    }
}
