//
//  TaskDetailsPopupViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 21.01.2022.
//

import UIKit

class TaskDetailsPopupViewController: UIViewController, TaskDetailsPopupView {
    
    private let popupView = TaskDetailsPopupViewImpl()
    private let presenter: TaskDetailsPopupPresenter!
    
    init(presenter: TaskDetailsPopupPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
        definesPresentationContext = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = popupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        presenter.onViewAttached(view: self)
        presenter.getTaskByIndex()
    }
    
    func getTaskByIndex(task: TaskEntity) {
        popupView.titleText.text = task.titleText
        popupView.descriptionText.text = task.descriptionText
        popupView.taskDateLabel.text = task.date
        popupView.taskImageView.image = task.image
        popupView.backgroundView.backgroundColor = task.color
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}



