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
        static let taskCheckMarkButton: CGFloat = 30
    }
    
    private let bacgroundView = UIView()
    private let titleLabel = UILabel()
    private let illustrationImageView = UIImageView()
    private let taskCurrentDataLabel = UILabel()
    private let taskCheckMarkButton = UIButton()
    private let dateLabel = UILabel()
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy, h:mm a"
        return dateFormatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(task: TaskEntity) {
        
        titleLabel.text = task.title
        let dateString = dateFormatter.string(from: task.currentDate ?? Date())
        dateLabel.text = dateString

        guard let imageData = task.image else {return}
        illustrationImageView.image = UIImage(data: imageData)
    }
    
    func configureView() {
        
        self.addSubview(bacgroundView)
        bacgroundView.addSubview(illustrationImageView)
        bacgroundView.addSubview(titleLabel)
        bacgroundView.addSubview(taskCheckMarkButton)
        bacgroundView.addSubview(dateLabel)
        
        bacgroundView.backgroundColor = .white
        bacgroundView.layer.cornerRadius = Constants.cellCornerRadius
        bacgroundView.layer.borderWidth = CGFloat(3)
//        bacgroundView.layer.borderColor = UIColor.black.cgColor
        bacgroundView.clipsToBounds = true
        
        
        taskCheckMarkButton.backgroundColor = .none
        taskCheckMarkButton.setImage(UIImage(systemName: "square", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
//        taskCheckMarkButton.addTarget(self, action: #selector(pres), for: .touchUpInside)
        
        taskCheckMarkButton.contentMode = .scaleAspectFit
        taskCheckMarkButton.isUserInteractionEnabled = true
        taskCheckMarkButton.isAccessibilityElement = true
        taskCheckMarkButton.accessibilityTraits = .button
        taskCheckMarkButton.accessibilityLabel = "Mark as Complete"
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.textColor = .black
        
        illustrationImageView.layer.cornerRadius = (self.bounds.height)/4
        illustrationImageView.clipsToBounds = true
        
        dateLabel.font = .systemFont(ofSize: 15, weight: .light)
        dateLabel.textAlignment = .left
        
    }
    
    // MARK: - Configure Layout Constraints
    
    func configureLayoutConstraints() {
        
        [bacgroundView, titleLabel, illustrationImageView, taskCurrentDataLabel, taskCheckMarkButton, dateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            bacgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bacgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bacgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            bacgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
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
            
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.taskDataLabelConstant),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.taskDataLabelConstant),
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -2*Constants.taskDataLabelConstant),
            dateLabel.heightAnchor.constraint(equalToConstant: 2*Constants.taskDataLabelConstant),
        ])
    }
}
