//
//  TaskDetailViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    private var titleTextField = UITextField()
    private var imageView = UIImageView()
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
        view.addSubview(titleTextField)
        
        titleTextField.frame = CGRect(x: 25, y: 150, width: 200, height: 20)
        presenter.setData()
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 50, height: view.bounds.width - 50)
        view.addSubview(imageView)
        imageView.center = view.center
        imageView.backgroundColor = .black.withAlphaComponent(0.3)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeButtonDidPressed))
        
    }
    
    @objc func removeButtonDidPressed() {
        presenter.popViewController(view: self)
    }
    
}

// MARK: - TaskDetailView

extension TaskDetailViewController: TaskDetailView {
    func setData(title: String?, image: UIImage?) {
        titleTextField.text = title
        imageView.image = image
        self.title = title
    }
}
