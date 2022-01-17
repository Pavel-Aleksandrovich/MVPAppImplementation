//
//  TaskListCell.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

class TaskListCell: UITableViewCell, TaskListCellView {
    
    let titleLabel = UILabel()
    let taskImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        self.addSubview(taskImageView)
        taskImageView.translatesAutoresizingMaskIntoConstraints = false
        taskImageView.layer.cornerRadius = (self.bounds.height - 4)/2
        taskImageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            taskImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            taskImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            taskImageView.heightAnchor.constraint(equalToConstant: self.bounds.height - 4),
            taskImageView.widthAnchor.constraint(equalToConstant: self.bounds.height - 4)
        ])
        
        
    }
}
