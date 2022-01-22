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
    func addButtonPressed(parametrs: TaskEntity)
    func onViewAttached(view: AddTaskView)
    func isEnabledSaveButton(text: String) -> UIColor
    func popViewController(navigationController: UINavigationController?)
}

protocol AddTaskView: AnyObject {
    func setViewBackgrounColor(color: UIColor?)
    func setViewTitle(title: String?)
    func setSaveButtonColor(color: UIColor)
    func showChooseSourceTypeAlertController()
    func showImagePickerController(sourceType: UIImagePickerController.SourceType)
}

final class AddTaskPresenterImpl: AddTaskPresenter {
    private weak var view: AddTaskView?
    private let delegate: AddTaskPresenterDelegate
    private let router: AddTaskRouter
    
    init(router: AddTaskRouter, delegate: AddTaskPresenterDelegate) {
        self.router = router
        self.delegate = delegate
    }
    
    func isEnabledSaveButton(text: String) -> UIColor {
        
        if text.isEmpty {
            return .gray.withAlphaComponent(0.6)
        } else {
            return .red
        }
    }
    
    func onViewAttached(view: AddTaskView) {
        view.setViewTitle(title: "Add Task")
        view.setViewBackgrounColor(color: .white.withAlphaComponent(0.9))
        view.setSaveButtonColor(color: .gray.withAlphaComponent(0.6))
        self.view = view
    }
    
    func addButtonPressed(parametrs: TaskEntity) {
        delegate.addTaskPresenter(presenter: self, task: parametrs)
    }
    
    func popViewController(navigationController: UINavigationController?) {
        router.popViewController(navigationController: navigationController, animated: false)
    }
}
