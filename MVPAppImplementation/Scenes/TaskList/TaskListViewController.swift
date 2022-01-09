//
//  ViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

class TaskListViewController: UIViewController {
    private enum Constants {
        static let IDENTIFIER_CELL = "TaskCell"
    }
    private var presenter: TaskListPresenter!
    private let tableView = UITableView()
    private let addTaskButton = UIButton()
    
    init(presenter: TaskListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.onViewAttachet(view: self)
        setupViews()
        presenter.setTitle()
        setButtonContstraints()
        setButtonAttributes()
    }
    
    private func setupViews() {
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.addSubview(addTaskButton)
        
        tableView.frame = view.bounds
        tableView.register(TaskListCell.self, forCellReuseIdentifier: Constants.IDENTIFIER_CELL)
    }
    
    private func setButtonContstraints() {
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addTaskButton.widthAnchor.constraint(equalToConstant: view.bounds.width/5),
            addTaskButton.heightAnchor.constraint(equalToConstant: view.bounds.width/5),
            addTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            addTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
    private func setButtonAttributes() {
        addTaskButton.backgroundColor = .green
        addTaskButton.layer.cornerRadius = view.bounds.width/10
        addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addTaskButtonTapped() {
        presenter.addTaskButtonTapped()
    }
    
}

// MARK: - TaskListView

extension TaskListViewController: TaskListView {
    
    func setTitle(title: String?) {
        self.title = title
    }
    
    func addTask() {
        print("tap")
//        let vc = AddTaskAssembly.assembler()
//        navigationController?.pushViewController(vc, animated: false)
    }
    
}

// MARK: - UITableViewDataSource

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfTasks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.IDENTIFIER_CELL, for: indexPath) as! TaskListCell
//        cell.textLabel?.text = presenter.taskTitle?[indexPath.row].title
        let task = presenter.getTaskByIndex(index: indexPath.row)
        cell.textLabel?.text = task.title
//        presenter.configure(cell: cell, row: indexPath.row)
        return cell
    }
    
}

