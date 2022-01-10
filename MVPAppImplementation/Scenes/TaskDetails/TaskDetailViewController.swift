//
//  TaskDetailViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    private var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
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
        titleLabel.text = "d"
        titleLabel.center = view.center
    }
}
extension TaskDetailViewController: TaskDetailView {
    func setTitle(title: String?) {
        titleLabel.text = title
    }
}
