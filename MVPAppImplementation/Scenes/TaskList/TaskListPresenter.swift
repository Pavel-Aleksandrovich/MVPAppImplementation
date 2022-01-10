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
}

protocol TaskListView: AnyObject {
    func setTitle(title: String?)
    func refreshTasksView()
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
}
