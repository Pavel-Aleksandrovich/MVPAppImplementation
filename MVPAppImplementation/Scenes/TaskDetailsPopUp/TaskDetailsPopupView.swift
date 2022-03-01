//
//  TaskDetailsPopupView.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 25.01.2022.
//

import UIKit

protocol TaskDetailsPopupView: UIView {
    func configure(task: TaskE)
    var closeButtonTappedHandler: (() -> ())? { get set }
}

final class TaskDetailsPopupViewImpl: UIView, TaskDetailsPopupView {
    
    private let backgroundView = UIView()
    private let titleLabel = UILabel()
    private let taskDateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let scrollView = UIScrollView()
    private let closeButton = UIButton()
    private let checkMurkButton = UIButton()
    private let imageView = UIImageView()
    
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
    
    func configure(task: TaskE) {
        titleLabel.text = task.titleText
        descriptionLabel.text = task.descriptionText
        taskDateLabel.text = task.date
        imageView.image = task.image
        backgroundView.layer.borderColor = task.color.cgColor
        
        closeButton.setTitleColor(task.color, for: .normal)
        closeButton.layer.borderColor = task.color.cgColor
    }
    
    private func closeButtonAddTarget() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func closeButtonTapped() {
        closeButtonTappedHandler?()
    }
    
    private func configureViewAttributes() {
        backgroundColor = .black.withAlphaComponent(0.3)
        
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 25
        backgroundView.clipsToBounds = true
        backgroundView.layer.borderWidth = 5
        
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds  = true
        
        
        closeButton.layer.borderWidth = CGFloat(3)
        closeButton.layer.cornerRadius = 25
        closeButton.setTitle("CLOSE", for: .normal)
        
        titleLabel.textAlignment = .center
        
        scrollView.showsVerticalScrollIndicator = false
        
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        
        checkMurkButton.backgroundColor = .green
        checkMurkButton.setTitle("Task Completed", for: .normal)
        checkMurkButton.titleLabel?.font = UIFont(name: "Kailasa", size: 20)
        checkMurkButton.clipsToBounds = true
        
        taskDateLabel.textAlignment = .center
    }
    
    private func configureView() {
        
        [backgroundView, closeButton, titleLabel, scrollView, descriptionLabel, checkMurkButton, taskDateLabel, imageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(backgroundView)
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(titleLabel)
//        scrollView.addSubview(checkMurkButton)
        scrollView.addSubview(taskDateLabel)
        scrollView.addSubview(imageView)
        scrollView.addSubview(descriptionLabel)
    }
    
    private func configureLayout() {
        
        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            backgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            scrollView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            closeButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            closeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            closeButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            
//            checkMurkButton.heightAnchor.constraint(equalToConstant: 30),
//            checkMurkButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            checkMurkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
////            checkMurkButton.widthAnchor.constraint(equalToConstant: 200),
//            checkMurkButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            
//            taskDateLabel.heightAnchor.constraint(equalToConstant: 30),
//            taskDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            taskDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            taskDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            
        ])
    }
}
