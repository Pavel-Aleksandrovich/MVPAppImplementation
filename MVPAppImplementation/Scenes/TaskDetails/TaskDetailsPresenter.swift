//
//  AddTaskPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

protocol TaskDetailsPresenter {
    func onViewAttached(controller: TaskDetailsController,view: TaskDetailsView)
}

protocol TaskDetailsController: AnyObject {
    func setViewBackgrounColor(color: UIColor?)
    func setViewTitle(title: String?)
    func setSaveButtonColor(color: UIColor)
    func configure(task: TaskEntity)
    var saveTaskButtonTappedHandler: ((Task) -> ())? { get set }
    var colorPickerButtonTappedHandler: ((UIButton) -> ())? { get set }
}

final class TaskDetailsPresenterImpl: TaskDetailsPresenter {
    private weak var controller: TaskDetailsController?
    private weak var view: TaskDetailsView?
    private let router: TaskDetailsRouter
    private let index: Int?
    private let taskService: TaskService
    private var task: TaskEntity?
    
    init(router: TaskDetailsRouter, index: Int?, taskService: TaskService) {
        self.router = router
        self.index = index
        self.taskService = taskService
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
        let tasks = taskService.getTasks()
        task = taskService.getTaskBy(id: tasks[index].objectID)
        
        guard let task = task else { return }
        controller?.configure(task: task)
    }
    
    private func addTaskButtonPressed() {
        controller?.saveTaskButtonTappedHandler = { [weak self] sourceTask in
            if self?.index == nil {
                self?.taskService.createTask(sourceTask: sourceTask)
                self?.router.popViewController(animated: false)
            } else {
                self?.taskService.updateTask(sourceTask: sourceTask, task: (self?.task)!)
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
