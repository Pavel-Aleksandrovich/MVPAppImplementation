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
        presenter.onViewAttached(view: self)
        setupViews()
        presenter.setTitle()
        setButtonContstraints()
        setButtonAttributes()
        
        let longPressGecture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        view.addGestureRecognizer(longPressGecture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func longPress(_ press: UIGestureRecognizer) {
        let popup = TaskDetailsPopupViewController()
        present(popup, animated: false) {
        }
        let location: CGPoint = press.location(in: tableView)
        
        let indexPath: IndexPath = tableView.indexPathForRow(at: location)!
        print(indexPath.row)
    }
    
    
    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.addSubview(addTaskButton)
        
        tableView.frame = view.bounds
        tableView.register(TaskCell.self,
                           forCellReuseIdentifier: Constants.IDENTIFIER_CELL)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
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
        presenter.addTaskButtonTapped(navigationController: self.navigationController)
    }
    
}

// MARK: - TaskListView

extension TaskListViewController: TaskListView {
    
    func setTitle(title: String?) {
        self.title = title
    }
    
    func deselectRow(indexPath: IndexPath, animated: Bool) {
        tableView.deselectRow(at: indexPath, animated: animated)
    }
}

// MARK: - UITableViewDataSource

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfTasks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.IDENTIFIER_CELL, for: indexPath) as! TaskCell
        
        let task = presenter.getTaskByIndex(index: indexPath.row)
        cell.configureCell(task: task)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            presenter.deleteTaskByIndex(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: - UITableViewDelegate

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.deselectRow(indexPath: indexPath)
        presenter.presentTaskDetail(navigationController: self.navigationController, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        presenter.moveCell(sourceIndexPath: sourceIndexPath.row, destinationIndexPath: destinationIndexPath.row)
    }
    
    
}
