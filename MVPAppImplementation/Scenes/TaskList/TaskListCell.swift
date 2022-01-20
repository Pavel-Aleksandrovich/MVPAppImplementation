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
    private let taskDataLabel = UILabel()
    private let taskCheckMarkButton = UIView()
    
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
        cellView.addSubview(taskDataLabel)
        cellView.addSubview(taskCheckMarkButton)
        
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = 20
        cellView.layer.borderWidth = CGFloat(0.05)
        cellView.layer.borderColor = UIColor.black.cgColor
        cellView.clipsToBounds = true
        
        [cellView, titleLabel, taskImageView, taskDataLabel, taskCheckMarkButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        taskCheckMarkButton.backgroundColor = .red
        
        taskDataLabel.font = .systemFont(ofSize: 15, weight: .light)
        taskDataLabel.textAlignment = .right
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.textColor = .orange
        
        taskImageView.layer.cornerRadius = (self.bounds.height)/2
        taskImageView.clipsToBounds = true
        
    }
    
    func configureCell(task: TaskEntity) {
        taskDataLabel.text = task.currentDate
        titleLabel.text = task.titleText
        taskImageView.image = task.image
        cellView.backgroundColor = task.color
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
            
            taskDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            taskDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40),
            taskDataLabel.heightAnchor.constraint(equalToConstant: 30),
            taskDataLabel.widthAnchor.constraint(equalToConstant: 150),
            
            taskCheckMarkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            taskCheckMarkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 40),
            taskCheckMarkButton.heightAnchor.constraint(equalToConstant: self.bounds.height/2),
            taskCheckMarkButton.widthAnchor.constraint(equalToConstant: self.bounds.height/2)
        ])
    }
}
