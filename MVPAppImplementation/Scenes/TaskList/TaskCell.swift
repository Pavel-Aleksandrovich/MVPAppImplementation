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
    
    private let backView = UIView()
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let currentDataLabel = UILabel()
    private let checkMarkButton = UIButton()
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
        imageView.image = UIImage(data: imageData)
    }
    
    func configureView() {
        
        self.addSubview(backView)
        backView.addSubview(imageView)
        backView.addSubview(titleLabel)
        backView.addSubview(checkMarkButton)
        backView.addSubview(dateLabel)
        
        backView.backgroundColor = .white
        backView.layer.cornerRadius = Constants.cellCornerRadius
        backView.layer.borderWidth = CGFloat(3)
//        bacgroundView.layer.borderColor = UIColor.black.cgColor
        backView.clipsToBounds = true
        
        
        checkMarkButton.backgroundColor = .none
        checkMarkButton.setImage(UIImage(systemName: "square", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
//        taskCheckMarkButton.addTarget(self, action: #selector(pres), for: .touchUpInside)
        
        checkMarkButton.contentMode = .scaleAspectFit
        checkMarkButton.isUserInteractionEnabled = true
        checkMarkButton.isAccessibilityElement = true
        checkMarkButton.accessibilityTraits = .button
        checkMarkButton.accessibilityLabel = "Mark as Complete"
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.textColor = .black
        
        imageView.layer.cornerRadius = (self.bounds.height)/4
        imageView.clipsToBounds = true
        
        dateLabel.font = .systemFont(ofSize: 15, weight: .light)
        dateLabel.textAlignment = .left
        
    }
    
    // MARK: - Configure Layout Constraints
    
    func configureLayoutConstraints() {
        
        [backView, titleLabel, imageView, currentDataLabel, checkMarkButton, dateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backView.topAnchor.constraint(equalTo: self.topAnchor),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.imageConstant),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.imageConstant),
            imageView.heightAnchor.constraint(equalToConstant: self.bounds.height/2),
            imageView.widthAnchor.constraint(equalToConstant: self.bounds.height/2),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.titleLabelConstant),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.titleLabelConstant),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.titleLabelConstant),
            titleLabel.heightAnchor.constraint(equalToConstant: 3*Constants.titleLabelConstant),
            
            checkMarkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.taskCheckMarkButtonConstant),
            checkMarkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 2*Constants.taskCheckMarkButtonConstant),
            checkMarkButton.heightAnchor.constraint(equalToConstant: Constants.taskCheckMarkButton),
            checkMarkButton.widthAnchor.constraint(equalToConstant: Constants.taskCheckMarkButton),
            
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.taskDataLabelConstant),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.taskDataLabelConstant),
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -2*Constants.taskDataLabelConstant),
            dateLabel.heightAnchor.constraint(equalToConstant: 2*Constants.taskDataLabelConstant),
        ])
    }
}
