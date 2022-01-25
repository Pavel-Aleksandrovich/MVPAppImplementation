//
//  TaskDetailsPopupPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 24.01.2022.
//

import Foundation

protocol TaskDetailsPopupView: AnyObject {
    func getTaskByIndex(task: TaskEntity)
}

protocol TaskDetailsPopupPresenter {
    func onViewAttached(view: TaskDetailsPopupView)
    func getTaskByIndex()
}

final class TaskDetailsPopupPresenterImpl: TaskDetailsPopupPresenter {
    
    private weak var view: TaskDetailsPopupView?
    private let index: Int
    private var taskSettings: TaskSettings
    
    init(index: Int, taskSettings: TaskSettings) {
        self.index = index
        self.taskSettings = taskSettings
    }
    
    func onViewAttached(view: TaskDetailsPopupView) {
        self.view = view
    }
    
    func getTaskByIndex() {
        let task = taskSettings.getTaskByIndex(index: index)
        view?.getTaskByIndex(task: task)
    }
}
