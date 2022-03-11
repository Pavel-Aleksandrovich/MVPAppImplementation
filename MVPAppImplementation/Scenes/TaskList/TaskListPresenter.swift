//
//  TaskListPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

protocol TaskListPresenter {
    func numberOfTasks() -> Int
    func onViewAttached(view: TaskListView)
    func deselectRow(indexPath: IndexPath)
    func deleteTaskByIndex(index: Int)
    func showTaskDetailsPopup(index: Int)
    func getTasks() -> [TaskEntity]
    }

protocol TaskListView: AnyObject {
    var showTaskDetailsHandler: ((TaskState) -> ())? { get set }
    func deselectRow(indexPath: IndexPath, animated: Bool)
}

protocol TaskListCellView {
    func configureCell(task: TaskEntity)
}

final class TaskListPresenterImpl: TaskListPresenter {
    
    private weak var view: TaskListView?
    private let router: TaskListRouter
    private let taskService: TaskService
    private var tasks = [TaskEntity]()
    
    init(router: TaskListRouter, taskService: TaskService) {
        self.router = router
        self.taskService = taskService
    }
    
    func onViewAttached(view: TaskListView) {
        self.view = view
        addTaskButtonTapped()
    }
    
    func numberOfTasks() -> Int {
        return taskService.getNumberOfTasks()
    }
    
    func getTasks() -> [TaskEntity] {
        tasks = taskService.getTasks()
        return tasks
    }
    
    private func addTaskButtonTapped() {
        view?.showTaskDetailsHandler = { [weak self] taskState in
            self?.router.presentTaskDetails(animated: false, state: taskState)
        }
    }
    
    func deselectRow(indexPath: IndexPath) {
        view?.deselectRow(indexPath: indexPath, animated: false)
    }
    
    func deleteTaskByIndex(index: Int) {
        taskService.deleteTaskBy(id: tasks[index].objectID)
    }
    
    func showTaskDetailsPopup(index: Int) {
        router.presentTaskDetailsPopup(index: index)
    }
}
