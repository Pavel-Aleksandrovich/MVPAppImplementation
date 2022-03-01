//
//  TaskDetailsPopupPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 24.01.2022.
//

import Foundation

protocol TaskDetailsPopupController: AnyObject {
}

protocol TaskDetailsPopupPresenter {
    func onViewAttached(controller: TaskDetailsPopupController, view: TaskDetailsPopupView)
}

final class TaskDetailsPopupPresenterImpl: TaskDetailsPopupPresenter {
    
    private weak var controller: TaskDetailsPopupController?
    private weak var view: TaskDetailsPopupView?
    private let index: Int
    private let router: TaskDetailsPopupRouter
    private let taskService: TaskService
    private var tasks = [TaskEntity]()
    
    init(index: Int, router: TaskDetailsPopupRouter, taskService: TaskService) {
        self.index = index
        self.router = router
        self.taskService = taskService
    }
    
    func onViewAttached(controller: TaskDetailsPopupController,
                        view: TaskDetailsPopupView) {
        self.controller = controller
        self.view = view
        getTaskByIndex()
        dismissView()
    }
    
    private func getTaskByIndex() {
        tasks = taskService.getTasks()
        guard let task = taskService.getTaskBy(id: tasks[index].objectID) else { return }
        view?.configure(task: task)
//        let task = taskSettings.getTaskByIndex(index: index)
//        view?.configure(task: task)
    }
    
    private func dismissView() {
        view?.closeButtonTappedHandler = { [ weak self ] in
            self?.router.dismissView()
        }
    }
}
