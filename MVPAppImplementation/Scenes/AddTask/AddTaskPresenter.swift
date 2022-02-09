//
//  AddTaskPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

protocol AddTaskPresenter {
    func onViewAttached(view: AddTaskView)
    func isEnabledSaveButton(text: String) -> UIColor
    func setDataForAlertPhotoPicker()
    func presentColorPicker(viewController: UIViewController, sourceView: UIButton, delegate: AddTaskViewController)
    func presentFontPicker(viewController: UIViewController, sourceView: UIButton, delegate: AddTaskViewController)
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
    func configure(task: TaskEntity)
    var saveTaskButtonTappedHandler: ((TaskEntity) -> ())? { get set }
}

final class AddTaskPresenterImpl: AddTaskPresenter {
    private weak var view: AddTaskView?
    private let router: AddTaskRouter
    private var taskSettings: TaskSettings
    private let index: Int?
    
    init(router: AddTaskRouter, taskSettings: TaskSettings, index: Int?) {
        self.router = router
        self.taskSettings = taskSettings
        self.index = index
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
        configureView()
        addTaskButtonPressed()
    }
    
    private func configureView() {
       guard let index = index else { return }
        let task = taskSettings.getTaskByIndex(index: index)
        view?.configure(task: task)
    }
    
    func setDataForAlertPhotoPicker() {
        view?.showChooseSourceTypeAlertController(style: .actionSheet, title: "Shoose Image", message: nil, animated: false)
    }
    
    private func addTaskButtonPressed() {
        view?.saveTaskButtonTappedHandler = { [weak self] task in
            if self?.index == nil {
                self?.taskSettings.saveTask(task: task)
                self?.router.popViewController(animated: false)
            } else {
                self?.taskSettings.updateTaskByIndex(task: task, index: (self?.index)!)
                self?.router.popViewController(animated: false)
            }
        }
        
    }
    
    func presentColorPicker(viewController: UIViewController, sourceView: UIButton, delegate: AddTaskViewController) {
        router.presentColorPicker(viewController: viewController, animated: true, sourceView: sourceView, delegate: delegate)
    }
    
    func presentFontPicker(viewController: UIViewController, sourceView: UIButton, delegate: AddTaskViewController) {
        router.presentFontPicker(viewController: viewController, animated: true, sourceView: sourceView, delegate: delegate)
    }
}
