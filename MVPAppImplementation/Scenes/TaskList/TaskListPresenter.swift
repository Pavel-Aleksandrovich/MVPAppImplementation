//
//  TaskListPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

protocol TaskListPresenter {
    func setTitle()
    func numberOfTasks() -> Int
    func getTaskByIndex(index: Int) -> TaskEntity
    func onViewAttached(view: TaskListView)
    func addTaskButtonTapped(navigationController: UINavigationController?)
    func presentTaskDetail(navigationController: UINavigationController?, indexPath: IndexPath)
    func deselectRow(indexPath: IndexPath)
    func deleteTaskByIndex(index: Int)
    func moveCell(sourceIndexPath: Int, destinationIndexPath: Int)
    }

protocol TaskListView: AnyObject {
    func setTitle(title: String?)
    func deselectRow(indexPath: IndexPath, animated: Bool)
}

protocol TaskListCellView {
    func configureCell(task: TaskEntity)
}

final class TaskListPresenterImpl: TaskListPresenter, AddTaskPresenterDelegate {
    
    private weak var view: TaskListView?
    private var router: TaskViewRouter
    private var taskSettings: TaskSettings
    
    init(router: TaskViewRouter, taskSettings: TaskSettings) {
        self.router = router
        self.taskSettings = taskSettings
    }
    
    func onViewAttached(view: TaskListView) {
        self.view = view
    }
    
    func  moveCell(sourceIndexPath: Int, destinationIndexPath: Int) {
        taskSettings.tasks.swapAt(sourceIndexPath, destinationIndexPath)
    }
    
    func setTitle() {
        view?.setTitle(title: "Tasks")
    }
    
    func numberOfTasks() -> Int {
        return taskSettings.numberOfTasks()
    }
    
    func addTaskAndSave(task: TaskEntity) {
        taskSettings.saveTask(task: task)
    }
    
    func getTaskByIndex(index: Int) -> TaskEntity {
        return taskSettings.getTaskByIndex(index: index)
    }
    
    func addTaskButtonTapped(navigationController: UINavigationController?) {
        router.presentAddTask(navigationController: navigationController, animated: false, addTaskPresenterDelegate: self)
    }
    
    func presentTaskDetail(navigationController: UINavigationController?, indexPath: IndexPath) {
        let task = taskSettings.getTaskByIndex(index: indexPath.row)
        
        router.presentTaskDetail(navigationController: navigationController,
                                 task: task, animated: false) { [ weak self ] task in
            self?.taskSettings.removeTask(index: indexPath.row)
        }
    }
    
    func deselectRow(indexPath: IndexPath) {
        view?.deselectRow(indexPath: indexPath, animated: false)
    }
    
    func deleteTaskByIndex(index: Int) {
        taskSettings.removeTask(index: index)
    }
}
