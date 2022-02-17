//
//  TaskDetailsPopupView.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 25.01.2022.
//

import UIKit

protocol TaskDetailsPopupView: UIView {
    func configure(task: TaskEntity)
    var complitionHandler: (() -> ())? { get set }
}

final class TaskDetailsPopupViewImpl: UIView, TaskDetailsPopupView {
    
    private let backgroundView = UIView()
    private let titleText = UILabel()
    private let taskDateLabel = UILabel()
    private let descriptionText = UILabel()
    private let scrollView = UIScrollView()
    private let closeButton = UIButton()
    private let checkMurkButton = UIButton()
    private let taskImageView = UIImageView()
    
    var complitionHandler: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        closeButtonAddTarget()
        
        backgroundColor = .black.withAlphaComponent(0.3)
        
        addSubview(backgroundView)
        
        backgroundView.addSubview(closeButton)
        backgroundView.addSubview(titleText)
        backgroundView.addSubview(scrollView)
        backgroundView.addSubview(checkMurkButton)
        backgroundView.addSubview(taskDateLabel)
        backgroundView.addSubview(taskImageView)
        scrollView.addSubview(descriptionText)
        backgroundView.backgroundColor = .red
        backgroundView.layer.cornerRadius = 25
        backgroundView.clipsToBounds = true
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.backgroundColor = .green
//        closeButton.layer.cornerRadius = 25
        closeButton.setTitle("CLOSE", for: .normal)
        closeButton.titleLabel?.font = UIFont(name: "Kailasa", size: 30)
        closeButton.clipsToBounds = true
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleText.textAlignment = .center
        titleText.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.lineBreakMode = .byWordWrapping
        descriptionText.numberOfLines = 0
        descriptionText.sizeToFit()
        
        checkMurkButton.backgroundColor = .green
        closeButton.layer.cornerRadius = 25
        checkMurkButton.setTitle("Task Completed", for: .normal)
        checkMurkButton.titleLabel?.font = UIFont(name: "Kailasa", size: 20)
        checkMurkButton.clipsToBounds = true
        checkMurkButton.translatesAutoresizingMaskIntoConstraints = false
        
        taskDateLabel.textAlignment = .center
        taskDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        taskImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            
            closeButton.heightAnchor.constraint(equalToConstant: 60),
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            closeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            
            titleText.heightAnchor.constraint(equalToConstant: 60),
            titleText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleText.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            scrollView.topAnchor.constraint(equalTo: taskDateLabel.bottomAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            
            descriptionText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            descriptionText.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            descriptionText.topAnchor.constraint(equalTo: scrollView.topAnchor),
            descriptionText.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            descriptionText.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            checkMurkButton.heightAnchor.constraint(equalToConstant: 30),
            checkMurkButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            checkMurkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            checkMurkButton.widthAnchor.constraint(equalToConstant: 200),
            checkMurkButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            
            taskDateLabel.heightAnchor.constraint(equalToConstant: 30),
            taskDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            taskDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            taskDateLabel.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 10),
            
            taskImageView.topAnchor.constraint(equalTo: checkMurkButton.bottomAnchor),
            taskImageView.bottomAnchor.constraint(equalTo: closeButton.topAnchor),
            taskImageView.widthAnchor.constraint(equalToConstant: 300),
            taskImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(task: TaskEntity) {
        titleText.text = task.titleText
        descriptionText.text = task.descriptionText
        taskDateLabel.text = task.date
        taskImageView.image = task.image
        backgroundView.backgroundColor = task.color
    }
    
    private func closeButtonAddTarget() {
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc private func dismissView() {
        complitionHandler?()
    }
}
