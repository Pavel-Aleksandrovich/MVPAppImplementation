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
    func configure(cell: UITableViewCell, row: Int)
    func getTaskByIndex(index: Int) -> TaskEntity
    func onViewAttachet(view: TaskListView)
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
    
    func onViewAttachet(view: TaskListView) {
        self.view = view
    }
    func setTitle() {
        view?.setTitle(title: "Tasks")
    }
    
    func configure(cell: UITableViewCell, row: Int) {
        let task = tasks[row]
        cell.textLabel?.text = task.title
        
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
