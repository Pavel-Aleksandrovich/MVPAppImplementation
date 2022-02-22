//
//  TaskDetailsPopupViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 21.01.2022.
//

import UIKit

final class TaskDetailsPopupViewController: UIViewController, TaskDetailsPopupController {
    
    private let mainView: TaskDetailsPopupView
    private let presenter: TaskDetailsPopupPresenter
    
    init(presenter: TaskDetailsPopupPresenter) {
        self.presenter = presenter
        mainView = TaskDetailsPopupViewImpl()
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
        definesPresentationContext = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(controller: self, view: mainView)
    }
}



