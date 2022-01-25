//
//  TaskDetailsPopupViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 21.01.2022.
//

import UIKit

class TaskDetailsPopupViewController: UIViewController, TaskDetailsPopupView {
    
    private let popupView = TaskDetailsPopupViewImpl()
    private let presenter: TaskDetailsPopupPresenter!
    
    init(presenter: TaskDetailsPopupPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = popupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        presenter.onViewAttached(view: self)
        presenter.getTaskByIndex()
    }
    
    func getTaskByIndex(task: TaskEntity) {
        popupView.titleText.text = task.titleText
        popupView.descriptionText.text = task.descriptionText
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}

class TaskDetailsPopupViewImpl: UIView {
    
    let view = UIView()
    let titleText = UILabel()
    let descriptionText = UILabel()
    let scrollView = UIScrollView()
    let closeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black.withAlphaComponent(0.3)
        
        addSubview(view)
        
        view.addSubview(closeButton)
        view.addSubview(titleText)
        view.addSubview(scrollView)
        scrollView.addSubview(descriptionText)
        view.backgroundColor = .red
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.backgroundColor = .green
//        closeButton.layer.cornerRadius = 25
        closeButton.setTitle("CLOSE", for: .normal)
        closeButton.titleLabel?.font = UIFont(name: "Kailasa", size: 30)
        closeButton.clipsToBounds = true
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        titleText.text = "title"
        titleText.textAlignment = .center
        titleText.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.lineBreakMode = .byWordWrapping
        descriptionText.numberOfLines = 0
        descriptionText.sizeToFit()
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            
            closeButton.heightAnchor.constraint(equalToConstant: 60),
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            closeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            
            titleText.heightAnchor.constraint(equalToConstant: 60),
            titleText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleText.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            scrollView.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            
            descriptionText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            descriptionText.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            descriptionText.topAnchor.constraint(equalTo: scrollView.topAnchor),
            descriptionText.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            descriptionText.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

