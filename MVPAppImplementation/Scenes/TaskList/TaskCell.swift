//
//  TaskListCell.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

protocol Delegate: AnyObject {
    func checkMarkTap(bool: Bool, task: TaskEntity, index: Int)
}


final class TaskCell: UICollectionViewCell, TaskListCellView {
    
    private enum Constants {
        static let cellCornerRadius = CGFloat(14)
        static let imageConstant = CGFloat(5)
        static let titleLabelConstant = CGFloat(10)
        static let taskCheckMarkButtonConstant = CGFloat(20)
        static let taskDataLabelConstant = CGFloat(10)
        static let taskCheckMarkButton: CGFloat = 30
    }
    weak var delegate: Delegate?
    private let cellView = UIView()
    private let titleLabel = UILabel()
    private let illustrationImageView = UIImageView()
    private let taskCurrentDataLabel = UILabel()
    private let taskCheckMarkButton = UIButton()
    private let taskDataLabel = UILabel()
    private var completed: Bool!
    private var task: TaskEntity!
    private var index: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(task: TaskEntity, index: Int) {
        titleLabel.text = task.titleText
        illustrationImageView.image = task.image
        cellView.backgroundColor = task.color
        taskDataLabel.text = task.date
        
        self.index = index
        print(task.completed)
        completed = task.completed
        self.task = task
        
        let symbolName: String
        
        if task.completed {
          symbolName = "square"
        } else {
          symbolName = "checkmark.square"
        }

        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: symbolName, withConfiguration: configuration)
        taskCheckMarkButton.setImage(image, for: .normal)
    }
    
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
        
        taskCheckMarkButton.backgroundColor = .none
        taskCheckMarkButton.setImage(UIImage(systemName: "square", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        taskCheckMarkButton.addTarget(self, action: #selector(pres), for: .touchUpInside)
        
        taskCheckMarkButton.contentMode = .scaleAspectFit
        taskCheckMarkButton.isUserInteractionEnabled = true
        taskCheckMarkButton.isAccessibilityElement = true
        taskCheckMarkButton.accessibilityTraits = .button
        taskCheckMarkButton.accessibilityLabel = "Mark as Complete"
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.textColor = .black
        
        illustrationImageView.layer.cornerRadius = (self.bounds.height)/4
        illustrationImageView.clipsToBounds = true
        
        taskDataLabel.font = .systemFont(ofSize: 15, weight: .light)
        taskDataLabel.textAlignment = .left
        
    }
    
    @objc func pres() {
        print("press")
        
        guard let task = task, var completed = completed else {return}
        completed.toggle()
        delegate?.checkMarkTap(bool: completed, task: task, index: index)
        print(completed)
        task.completed = completed
        print(task.completed)
        let symbolName: String
        
        if completed {
          symbolName = "square"
        } else {
          symbolName = "checkmark.square"
        }

        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: symbolName, withConfiguration: configuration)
        taskCheckMarkButton.setImage(image, for: .normal)
        
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
            taskCheckMarkButton.heightAnchor.constraint(equalToConstant: Constants.taskCheckMarkButton),
            taskCheckMarkButton.widthAnchor.constraint(equalToConstant: Constants.taskCheckMarkButton),
            
            taskDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.taskDataLabelConstant),
            taskDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.taskDataLabelConstant),
            taskDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -2*Constants.taskDataLabelConstant),
            taskDataLabel.heightAnchor.constraint(equalToConstant: 2*Constants.taskDataLabelConstant),
        ])
    }
}
