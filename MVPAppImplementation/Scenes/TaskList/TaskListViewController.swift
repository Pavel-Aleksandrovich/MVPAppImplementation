//
//  ViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

class TaskListViewController: UIViewController {
    
    var presenter: TaskListPresenter!
    private let tableView = UITableView()
    private let reuseIdentifierCell = "cell"
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        presenter.setTitle()
        setButtonContstraints()
        setButtonAttributes()
    }
    
    private func setupViews() {
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.addSubview(button)
        
        tableView.frame = view.bounds
        tableView.register(TaskListCell.self, forCellReuseIdentifier: reuseIdentifierCell)
    }
    
    private func setButtonContstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: view.bounds.width/5),
            button.heightAnchor.constraint(equalToConstant: view.bounds.width/5),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
    private func setButtonAttributes() {
        button.backgroundColor = .green
        button.layer.cornerRadius = view.bounds.width/10
        button.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }
    
    @objc private func addTask() {
        let vc = AddTaskAssembly.assembler()
        navigationController?.pushViewController(vc, animated: false)
    }
    
}

// MARK: - TaskListView

extension TaskListViewController: TaskListView {
    
    func setTitle(title: String?) {
        self.title = title
    }
    
}

// MARK: - UITableViewDataSource

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCell, for: indexPath) as! TaskListCell
        
        return cell
    }
    
}

