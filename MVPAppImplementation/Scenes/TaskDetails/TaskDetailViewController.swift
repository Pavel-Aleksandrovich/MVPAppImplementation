//
//  TaskDetailViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    private let titleTextField = UITextField()
    private let descriptionTextView = UITextView()
    private let avatarImageView = UIImageView()
    private let presenter: TaskDetailsPresenter!
    
    init(presenter: TaskDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(view: self)
        view.backgroundColor = .white
        view.addSubview(titleTextField)
        
        titleTextField.frame = CGRect(x: 15, y: 110, width: view.bounds.width - 30, height: 30)
        
        descriptionTextView.frame = CGRect(x: 15, y: 150, width: view.bounds.width - 30, height: 200)
        view.addSubview(descriptionTextView)
        descriptionTextView.backgroundColor = .none
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = CGFloat(1)
        
        avatarImageView.frame = CGRect(x: 15, y: view.bounds.width, width: view.bounds.width - 30, height: view.bounds.width - 30)
        view.addSubview(avatarImageView)
//        avatarImageView.center = view.center
        avatarImageView.backgroundColor = .black.withAlphaComponent(0.3)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeButtonDidPressed))
        
    }
    
    @objc func removeButtonDidPressed() {
        presenter.removeButtonDidPressed(navigationController: self.navigationController)
    }
    
}

// MARK: - TaskDetailView

extension TaskDetailViewController: TaskDetailView {
    
    func setTask(task: TaskEntity) {
        titleTextField.text = task.titleText
        avatarImageView.image = task.image
        descriptionTextView.text = task.descriptionText
        self.title = task.titleText
    }
}
