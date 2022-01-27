//
//  AddTaskPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

protocol AddTaskPresenter {
    func addTaskButtonPressed(task: TaskEntity)
    func onViewAttached(view: AddTaskView)
    func isEnabledSaveButton(text: String) -> UIColor
    func popViewController(navigationController: UINavigationController?)
    func setDataForAlertPhotoPicker()
    func presentColorPicker(viewController: UIViewController, sourceView: UIButton, delegate: AddTaskViewController)
}

protocol AddTaskView: AnyObject {
    func setViewBackgrounColor(color: UIColor?)
    func setViewTitle(title: String?)
    func setSaveButtonColor(color: UIColor)
    func showChooseSourceTypeAlertController(style: UIAlertController.Style,
                                             title: String?,
                                             message: String?,
                                             animated: Bool)
    func showImagePickerController(sourceType: UIImagePickerController.SourceType)
}

final class AddTaskPresenterImpl: AddTaskPresenter {
    private weak var view: AddTaskView?
    private let router: AddTaskRouter
    private var taskSettings: TaskSettings
    
    init(router: AddTaskRouter, taskSettings: TaskSettings) {
        self.router = router
        self.taskSettings = taskSettings
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
    
    func setDataForAlertPhotoPicker() {
        view?.showChooseSourceTypeAlertController(style: .actionSheet, title: "Shoose Image", message: nil, animated: false)
    }
    
    func addTaskButtonPressed(task: TaskEntity) {
        taskSettings.saveTask(task: task)
    }
    
    func popViewController(navigationController: UINavigationController?) {
        router.popViewController(navigationController: navigationController, animated: false)
    }
    
    func presentColorPicker(viewController: UIViewController, sourceView: UIButton, delegate: AddTaskViewController) {
        router.presentColorPicker(viewController: viewController, animated: true, sourceView: sourceView, delegate: delegate)
    }
}
