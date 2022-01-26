//
//  ViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

class TaskListViewController: UIViewController {
    private enum Constants {
        static let identifierCell = "TaskCell"
    }
    
    private let presenter: TaskListPresenter!
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    private func setupViews() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.addSubview(addTaskButton)
        
        tableView.frame = view.bounds
        tableView.register(TaskCell.self,
                           forCellReuseIdentifier: Constants.identifierCell)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifierCell, for: indexPath) as! TaskCell
        
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
        presenter.showTaskDetailBylongTouch(index: indexPath.row, viewController: self)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        presenter.moveCell(sourceIndexPath: sourceIndexPath.row, destinationIndexPath: destinationIndexPath.row)
    }
    
}

// MARK: - UIContextMenuConfiguration

extension TaskListViewController {
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return contextMenuConfiguration { [ weak self ] action in
            guard let self = self else { return }
            
            if action == "tapped delete" {
                self.presenter.deleteTaskByIndex(index: indexPath.row)
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            } else if action == "Edit" {
                self.presenter.presentTaskDetail(navigationController: self.navigationController, indexPath: indexPath)
            }
            
        }
    }
}
