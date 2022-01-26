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
        static let heightCell = CGFloat(140)
        static let widthAddTaskButton = CGFloat(100)
        static let widthCellConstant = CGFloat(20)
        static let mainTitle = "Tasks"
        static let spacingBetweenCell = CGFloat(10)
    }
    
    private let layout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView!
    private let presenter: TaskListPresenter!
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
        configureView()
    }
    
    private func configureView() {
        title = Constants.mainTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        addTaskButton.backgroundColor = .green
        addTaskButton.layer.cornerRadius = Constants.widthAddTaskButton/2
        addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: Constants.identifierCell)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addSubview(addTaskButton)
        
        view.addSubview(collectionView)
        view.backgroundColor = .white
        
        layout.itemSize = CGSize(width: collectionView.frame.width - Constants.widthCellConstant, height: Constants.heightCell)
        layout.minimumLineSpacing = Constants.spacingBetweenCell
    }
    
    @objc private func addTaskButtonTapped() {
        presenter.addTaskButtonTapped(navigationController: self.navigationController)
    }
    
}

// MARK: - TaskListView

extension TaskListViewController: TaskListView {
    
    func deselectRow(indexPath: IndexPath, animated: Bool) {
        collectionView.deselectItem(at: indexPath, animated: animated)
    }
}

// MARK: - UICollectionViewDataSource

extension TaskListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfTasks()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.identifierCell, for: indexPath) as! TaskCell
        
        let task = presenter.getTaskByIndex(index: indexPath.row)
        cell.configureCell(task: task)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension TaskListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        presenter.deselectRow(indexPath: indexPath)
        presenter.showTaskDetailBylongTouch(index: indexPath.row, viewController: self)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TaskListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width - Constants.widthCellConstant, height: Constants.heightCell)
    }
}

// MARK: - UIContextMenuConfiguration

extension TaskListViewController {
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return contextMenuConfiguration { [ weak self ] action in
            guard let self = self else { return }
            
            switch action {
            case .deleteConfirmation:
                
                self.presenter.deleteTaskByIndex(index: indexPath.row)
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
                
            case .edit:
                self.presenter.presentTaskDetail(navigationController: self.navigationController, indexPath: indexPath)
                
            case .showDetails:
                print("show details")
            }
            
        }
    }
}

// MARK: - viewWillAppear

extension TaskListViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Set Layout Constraints viewDidLayoutSubviews
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        [collectionView, addTaskButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addTaskButton.widthAnchor.constraint(equalToConstant: Constants.widthAddTaskButton),
            addTaskButton.heightAnchor.constraint(equalToConstant: Constants.widthAddTaskButton),
            addTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.widthAddTaskButton/2),
            addTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.widthAddTaskButton)
        ])
    }
}
