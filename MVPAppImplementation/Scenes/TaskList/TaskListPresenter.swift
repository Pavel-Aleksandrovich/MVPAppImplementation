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
    func addTaskButtonTapped(view: TaskListViewController)
    func presentTaskDetail(view: TaskListViewController, indexPath: IndexPath)
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
//    private var tasks = [TaskEntity]()
    private var router: TaskViewRouter
    
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
//        return tasks.count
        return TaskSettings.shared.tasks.count
    }
    
    func addTaskPresenter(presenter: AddTaskPresenter, task: TaskEntity) {
//        tasks.append(task)
//        view?.refreshTasksView()
        TaskSettings.shared.saveTask(title: task.taskTitle)
    }
    
    func getTaskByIndex(index: Int) -> TaskEntity {
//        let task = tasks[index]
        let task = TaskSettings.shared.tasks[index]
        return task
    }
    
    func addTaskButtonTapped(view: TaskListViewController) {
        router.presentAddTask(view: view, animated: false, addTaskPresenterDelegate: self)
    }
    
    func presentTaskDetail(view: TaskListViewController, indexPath: IndexPath) {
        let task = TaskSettings.shared.tasks[indexPath.row]
        router.presentTaskDetail(view: view, task: task, animated: false) { task in
//            self?.tasks.remove(at: indexPath.row)
            TaskSettings.shared.tasks.remove(at: indexPath.row)
//            self?.view?.refreshTasksView()
        }
    }
    
    func deselectRow(indexPath: IndexPath) {
        view?.deselectRow(indexPath: indexPath, animated: false)
    }
    
    func deleteTaskAtByIndex(index: Int) {
        TaskSettings.shared.tasks.remove(at: index)
    }
}
