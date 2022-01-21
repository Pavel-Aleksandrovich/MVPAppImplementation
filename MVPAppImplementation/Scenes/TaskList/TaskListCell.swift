//
//  TaskListCell.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

final class TaskListCell: UITableViewCell, TaskListCellView {
    
    private let cellView = UIView()
    private let titleLabel = UILabel()
    private let taskImageView = UIImageView()
    private let taskCurrentDataLabel = UILabel()
    private let taskCheckMarkButton = UIView()
    private let taskDataLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        
        self.addSubview(cellView)
        cellView.addSubview(taskImageView)
        cellView.addSubview(titleLabel)
        cellView.addSubview(taskCurrentDataLabel)
        cellView.addSubview(taskCheckMarkButton)
        cellView.addSubview(taskDataLabel)
        
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = 20
        cellView.layer.borderWidth = CGFloat(0.05)
        cellView.layer.borderColor = UIColor.black.cgColor
        cellView.clipsToBounds = true
        
        [cellView, titleLabel, taskImageView, taskCurrentDataLabel, taskCheckMarkButton, taskDataLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        taskCheckMarkButton.backgroundColor = .red
        
        taskCurrentDataLabel.font = .systemFont(ofSize: 15, weight: .light)
        taskCurrentDataLabel.textAlignment = .right
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.textColor = .black
        
        taskImageView.layer.cornerRadius = (self.bounds.height)/2
        taskImageView.clipsToBounds = true
        
        taskDataLabel.font = .systemFont(ofSize: 15, weight: .light)
        taskDataLabel.textAlignment = .left
        
    }
    
    func configureCell(task: TaskEntity) {
        taskCurrentDataLabel.text = task.currentDate
        titleLabel.text = task.titleText
        taskImageView.image = task.image
        cellView.backgroundColor = task.color
        taskDataLabel.text = task.date
    }
}

extension TaskListCell {
    
   private func setConstraints() {
    
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            taskImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            taskImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 30),
            taskImageView.heightAnchor.constraint(equalToConstant: self.bounds.height),
            taskImageView.widthAnchor.constraint(equalToConstant: self.bounds.height),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.widthAnchor.constraint(equalToConstant: self.bounds.width/1.7),
            
            taskCurrentDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            taskCurrentDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40),
            taskCurrentDataLabel.heightAnchor.constraint(equalToConstant: 30),
            taskCurrentDataLabel.widthAnchor.constraint(equalToConstant: 150),
            
            taskCheckMarkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            taskCheckMarkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 40),
            taskCheckMarkButton.heightAnchor.constraint(equalToConstant: self.bounds.height/2),
            taskCheckMarkButton.widthAnchor.constraint(equalToConstant: self.bounds.height/2),
            
            taskDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            taskDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            taskDataLabel.heightAnchor.constraint(equalToConstant: 30),
            taskDataLabel.widthAnchor.constraint(equalToConstant: self.frame.width),
        ])
    }
}
