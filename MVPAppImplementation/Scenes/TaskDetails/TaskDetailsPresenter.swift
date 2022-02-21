//
//  AddTaskPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

protocol TaskDetailsPresenter {
    func onViewAttached(controller: TaskDetailsController,view: TaskDetailsView)
    func isEnabledSaveButton(text: String) -> UIColor
}

protocol TaskDetailsController: AnyObject {
    func setViewBackgrounColor(color: UIColor?)
    func setViewTitle(title: String?)
    func setSaveButtonColor(color: UIColor)
    func configure(task: TaskEntity)
    var saveTaskButtonTappedHandler: ((TaskEntity) -> ())? { get set }
    var colorPickerButtonTappedHandler: ((UIButton) -> ())? { get set }
}

final class TaskDetailsPresenterImpl: TaskDetailsPresenter {
    private weak var controller: TaskDetailsController?
    private weak var view: TaskDetailsView?
    private let router: TaskDetailsRouter
    private let taskSettings: TaskSettings
    private let index: Int?
    
    init(router: TaskDetailsRouter, taskSettings: TaskSettings, index: Int?) {
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
    
    func onViewAttached(controller: TaskDetailsController,
                        view: TaskDetailsView) {
        controller.setViewTitle(title: "Add Task")
        controller.setViewBackgrounColor(color: .white.withAlphaComponent(0.9))
        controller.setSaveButtonColor(color: .gray.withAlphaComponent(0.6))
        self.controller = controller
        self.view = view
        configureView()
        addTaskButtonPressed()
        presentColorPicker()
    }
    
    private func configureView() {
        guard let index = index else { return }
        let task = taskSettings.getTaskByIndex(index: index)
        controller?.configure(task: task)
    }
    
    private func addTaskButtonPressed() {
        controller?.saveTaskButtonTappedHandler = { [weak self] task in
            if self?.index == nil {
                self?.taskSettings.saveTask(task: task)
                self?.router.popViewController(animated: false)
            } else {
                self?.taskSettings.updateTaskByIndex(task: task, index: (self?.index)!)
                self?.router.popViewController(animated: false)
            }
        }
    }
    
    private func presentColorPicker() {
        controller?.colorPickerButtonTappedHandler = { [weak self] sourceView in
            self?.router.presentColorPicker(animated: true, sourceView: sourceView)
        }
    }
}
