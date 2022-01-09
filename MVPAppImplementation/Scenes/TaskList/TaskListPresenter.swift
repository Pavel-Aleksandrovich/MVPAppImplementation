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
    func addTask()
}

protocol TaskListCellView {
    
}

final class TaskListPresenterImpl: TaskListPresenter {
    
    private weak var view: TaskListView?
    private var tasks = [TaskEntity]()
    
    func onViewAttached(view: TaskListView) {
        self.view = view
    }
    func setTitle() {
        view?.setTitle(title: "Tasks")
    }
    
    func numberOfTasks() -> Int {
        return tasks.count
    }
    
    func getTaskByIndex(index: Int) -> TaskEntity {
        let task = tasks[index]
        return task
    }
    
    func addTaskButtonTapped() {
        view?.addTask()
    }
}
