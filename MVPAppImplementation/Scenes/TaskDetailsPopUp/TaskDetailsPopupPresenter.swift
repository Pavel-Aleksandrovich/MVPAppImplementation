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
    private let taskSettings: TaskSettings
    private let router: TaskDetailsPopupRouter
    
    init(index: Int, taskSettings: TaskSettings, router: TaskDetailsPopupRouter) {
        self.index = index
        self.taskSettings = taskSettings
        self.router = router
    }
    
    func onViewAttached(controller: TaskDetailsPopupController,
                        view: TaskDetailsPopupView) {
        self.controller = controller
        self.view = view
        getTaskByIndex()
        dismissView()
    }
    
    private func getTaskByIndex() {
        let task = taskSettings.getTaskByIndex(index: index)
        view?.configure(task: task)
    }
    
    private func dismissView() {
        view?.complitionHandler = { [ weak self ] in
            self?.router.dismissView()
        }
    }
}
