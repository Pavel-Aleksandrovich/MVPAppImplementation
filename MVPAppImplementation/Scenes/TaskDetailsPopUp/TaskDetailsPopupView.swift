//
//  TaskDetailsPopupView.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 25.01.2022.
//

import UIKit

protocol TaskDetailsPopupView: UIView {
    func configure(task: TaskEntity)
    var closeButtonTappedHandler: (() -> ())? { get set }
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
    
    var closeButtonTappedHandler: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureViewAttributes()
        closeButtonAddTarget()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
        configureLayout()
    }
    
    func configure(task: TaskEntity) {
        titleText.text = task.titleText
        descriptionText.text = task.descriptionText
        taskDateLabel.text = task.date
        taskImageView.image = task.image
        backgroundView.backgroundColor = task.color
    }
    
    private func closeButtonAddTarget() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func closeButtonTapped() {
        closeButtonTappedHandler?()
    }
    
    private func configureViewAttributes() {
        backgroundColor = .black.withAlphaComponent(0.3)
        
        backgroundView.backgroundColor = .red
        backgroundView.layer.cornerRadius = 25
        backgroundView.clipsToBounds = true
        
        closeButton.backgroundColor = .green
        closeButton.layer.cornerRadius = 25
        closeButton.setTitle("CLOSE", for: .normal)
        closeButton.titleLabel?.font = UIFont(name: "Kailasa", size: 30)
        closeButton.clipsToBounds = true
        
        titleText.textAlignment = .center
        
        scrollView.showsVerticalScrollIndicator = false
        
        descriptionText.lineBreakMode = .byWordWrapping
        descriptionText.numberOfLines = 0
        descriptionText.sizeToFit()
        
        checkMurkButton.backgroundColor = .green
        checkMurkButton.setTitle("Task Completed", for: .normal)
        checkMurkButton.titleLabel?.font = UIFont(name: "Kailasa", size: 20)
        checkMurkButton.clipsToBounds = true
        
        taskDateLabel.textAlignment = .center
    }
    
    private func configureView() {
        
        [backgroundView, closeButton, titleText, scrollView, descriptionText, checkMurkButton, taskDateLabel, taskImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(backgroundView)
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(titleText)
        scrollView.addSubview(checkMurkButton)
        scrollView.addSubview(taskDateLabel)
        scrollView.addSubview(taskImageView)
        scrollView.addSubview(descriptionText)
    }
    
    private func configureLayout() {
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
//            scrollView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            scrollView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
//            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            
//            backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
//            backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            backgroundView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            closeButton.heightAnchor.constraint(equalToConstant: 60),
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            closeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            
            titleText.heightAnchor.constraint(equalToConstant: 60),
            titleText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleText.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            
            
            
            descriptionText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            descriptionText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 30),
            descriptionText.topAnchor.constraint(equalTo: taskDateLabel.bottomAnchor, constant: 10),
            descriptionText.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            
//            descriptionText.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            checkMurkButton.heightAnchor.constraint(equalToConstant: 30),
            checkMurkButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            checkMurkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            checkMurkButton.widthAnchor.constraint(equalToConstant: 200),
            checkMurkButton.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 20),
            
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
}
