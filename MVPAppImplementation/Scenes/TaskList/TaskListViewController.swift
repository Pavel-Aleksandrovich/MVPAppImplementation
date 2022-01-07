//
//  ViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

class TaskListViewController: UIViewController {
    
    var presenter: TaskListPresenter!
    let tableView = UITableView()
    let reuseIdentifierCell = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        view.addSubview(tableView)
        
        presenter.setTitle()
        registerTableView()
        setTableViewConstraints()
        
    }
    
    private func setTableViewConstraints() {
        tableView.frame = view.bounds
    }
    
    private func registerTableView() {
        tableView.register(TaskListCell.self, forCellReuseIdentifier: reuseIdentifierCell)
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

