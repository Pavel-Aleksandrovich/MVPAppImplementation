//
//  TaskListCell.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

final class TaskCell: UICollectionViewCell, TaskListCellView {
    
    private enum Constants {
        static let cellCornerRadius = CGFloat(14)
        static let imageConstant = CGFloat(5)
        static let titleLabelConstant = CGFloat(10)
        static let taskCheckMarkButtonConstant = CGFloat(20)
        static let taskDataLabelConstant = CGFloat(10)
    }
    
    private let cellView = UIView()
    private let titleLabel = UILabel()
    private let illustrationImageView = UIImageView()
    private let taskCurrentDataLabel = UILabel()
    private let taskCheckMarkButton = UIView()
    private let taskDataLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(task: TaskEntity) {
        titleLabel.text = task.titleText
        illustrationImageView.image = task.image
        cellView.backgroundColor = task.color
        taskDataLabel.text = task.date
    }
}

private extension TaskCell {
    
    func configureView() {
        
        self.addSubview(cellView)
        cellView.addSubview(illustrationImageView)
        cellView.addSubview(titleLabel)
        cellView.addSubview(taskCheckMarkButton)
        cellView.addSubview(taskDataLabel)
        
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = Constants.cellCornerRadius
        cellView.layer.borderWidth = CGFloat(0.05)
        cellView.layer.borderColor = UIColor.black.cgColor
        cellView.clipsToBounds = true
        
        taskCheckMarkButton.backgroundColor = .red
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.textColor = .black
        
        illustrationImageView.layer.cornerRadius = (self.bounds.height)/4
        illustrationImageView.clipsToBounds = true
        
        taskDataLabel.font = .systemFont(ofSize: 15, weight: .light)
        taskDataLabel.textAlignment = .left
        
    }
    
    // MARK: - Configure Layout Constraints
    
    func configureLayoutConstraints() {
        
        [cellView, titleLabel, illustrationImageView, taskCurrentDataLabel, taskCheckMarkButton, taskDataLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: self.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            illustrationImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.imageConstant),
            illustrationImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.imageConstant),
            illustrationImageView.heightAnchor.constraint(equalToConstant: self.bounds.height/2),
            illustrationImageView.widthAnchor.constraint(equalToConstant: self.bounds.height/2),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.titleLabelConstant),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.titleLabelConstant),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.titleLabelConstant),
            titleLabel.heightAnchor.constraint(equalToConstant: 3*Constants.titleLabelConstant),
            
            taskCheckMarkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.taskCheckMarkButtonConstant),
            taskCheckMarkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 2*Constants.taskCheckMarkButtonConstant),
            taskCheckMarkButton.heightAnchor.constraint(equalToConstant: self.bounds.height/2),
            taskCheckMarkButton.widthAnchor.constraint(equalToConstant: self.bounds.height/2),
            
            taskDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.taskDataLabelConstant),
            taskDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.taskDataLabelConstant),
            taskDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -2*Constants.taskDataLabelConstant),
            taskDataLabel.heightAnchor.constraint(equalToConstant: 2*Constants.taskDataLabelConstant),
        ])
    }
}
