//
//  TaskListPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

protocol TaskListPresenter {
    func numberOfTasks() -> Int
    func getTaskByIndex(index: Int) -> TaskEntity
    func onViewAttached(view: TaskListView)
    func deselectRow(indexPath: IndexPath)
    func deleteTaskByIndex(index: Int)
    func showTaskDetailBylongTouch(index: Int, viewController: UIViewController)
    func onCompleteCheckBoxTapped(bool: Bool, index: Int, task: TaskEntity)
    }

protocol TaskListView: AnyObject {
    var addTaskButtonTappedHandler: ((Int?) -> ())? { get set }
    func deselectRow(indexPath: IndexPath, animated: Bool)
}

protocol TaskListCellView {
    func configureCell(task: TaskEntity, index: Int)
}

final class TaskListPresenterImpl: TaskListPresenter {
    
    private weak var view: TaskListView?
    private let router: TaskListRouter
    private let taskSettings: TaskSettings
    
    init(router: TaskListRouter, taskSettings: TaskSettings) {
        self.router = router
        self.taskSettings = taskSettings
    }
    
    func onViewAttached(view: TaskListView) {
        self.view = view
        addTaskButtonTapped()
    }
    
    func numberOfTasks() -> Int {
        return taskSettings.numberOfTasks()
    }
    
    func getTaskByIndex(index: Int) -> TaskEntity {
        return taskSettings.getTaskByIndex(index: index)
    }
    
    private func addTaskButtonTapped() {
        view?.addTaskButtonTappedHandler = { [weak self] index in
            self?.router.presentTaskDetails(animated: false, index: index)
        }
    }
    
    func deselectRow(indexPath: IndexPath) {
        view?.deselectRow(indexPath: indexPath, animated: false)
    }
    
    func deleteTaskByIndex(index: Int) {
        taskSettings.removeTask(index: index)
    }
    
    func showTaskDetailBylongTouch(index: Int, viewController: UIViewController) {
        router.presentTaskDetailBylongTouch(index: index, viewController: viewController)
    }
    
    func onCompleteCheckBoxTapped(bool: Bool, index: Int, task: TaskEntity) {
        taskSettings.updateTaskByIndex(task: task, index: index)
        print(bool)
        print("onCompleteCheckBoxTapped")
    }
}
