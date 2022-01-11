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
    func addTaskButtonTapped()
    func presentTaskDetail(indexPath: IndexPath)
    func deselectRow(indexPath: IndexPath)
    func deleteTaskAtByIndex(index: Int)
}

protocol TaskListView: AnyObject {
    func setTitle(title: String?)
    func refreshTasksView()
    func deselectRow(indexPath: IndexPath, animated: Bool)
}

protocol TaskListCellView {
    
}

final class TaskListPresenterImpl: TaskListPresenter, AddTaskPresenterDelegate {
    
    private weak var view: TaskListView?
    private var tasks = [TaskEntity]()
    var router: TaskViewRouter
    
    init(router: TaskViewRouter) {
        self.router = router
    }
    
    func onViewAttached(view: TaskListView) {
        self.view = view
    }
    
    func setTitle() {
        view?.setTitle(title: "Tasks")
    }
    
    func numberOfTasks() -> Int {
        return tasks.count
    }
    
    func addTaskPresenter(presenter: AddTaskPresenter, task: TaskEntity) {
        tasks.append(task)
        view?.refreshTasksView()
    }
    
    func getTaskByIndex(index: Int) -> TaskEntity {
        let task = tasks[index]
        return task
    }
    
    func addTaskButtonTapped() {
        router.presentAddTask(addTaskPresenterDelegate: self)
    }
    
    func presentTaskDetail(indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        router.presentTaskDetail(task: task)
    }
    
    func deselectRow(indexPath: IndexPath) {
        view?.deselectRow(indexPath: indexPath, animated: false)
    }
    
    func deleteTaskAtByIndex(index: Int) {
        tasks.remove(at: index)
    }
}
