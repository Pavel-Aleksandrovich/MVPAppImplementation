//
//  TaskDetailViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    private var titleLabel = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    private var presenter: TaskDetailsPresenter!
    
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
        view.addSubview(titleLabel)
        
        titleLabel.center = view.center
        presenter.setTitle()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeButtonDidPressed))
        
    }
    
    @objc func removeButtonDidPressed() {
        presenter.popViewController(view: self)
    }
    
}
extension TaskDetailViewController: TaskDetailView {
    func setTitle(title: String?) {
        titleLabel.text = title
    }
}
