//
//  TaskDetailsPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskDetailView: AnyObject {
    func setData(title: String?, image: UIImage?)
}

protocol TaskDetailsPresenter {
    func onViewAttached(view: TaskDetailView)
    func setData()
    func popViewController(view: TaskDetailViewController)
}

class TaskDetailsPresenterImpl: TaskDetailsPresenter {
    private var task: TaskEntity
    private weak var view: TaskDetailView?
    private var router: TaskDetailRouter
    private var deleteComplition: (TaskEntity) -> ()
    
    init(task: TaskEntity, router: TaskDetailRouter,
         deleteComplition: @escaping (TaskEntity) -> ()) {
        self.task = task
        self.router = router
        self.deleteComplition = deleteComplition
    }
    
    func onViewAttached(view: TaskDetailView) {
        self.view = view
    }
    func setData() {
        view?.setData(title: task.taskTitle, image: task.image )
    }
    
    func popViewController(view: TaskDetailViewController) {
        router.popViewController(view: view, animated: false)
        deleteComplition(task)
    }
}
