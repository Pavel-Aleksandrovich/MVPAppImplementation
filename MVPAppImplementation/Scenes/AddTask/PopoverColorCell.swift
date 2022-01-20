//
//  PopoverColorCell.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 20.01.2022.
//

import UIKit

class PopoverColorCell: UICollectionViewCell {
    
    var cellView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(cellView)
        cellView.center = contentView.center
        cellView.layer.cornerRadius = 18
        cellView.clipsToBounds = true
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
