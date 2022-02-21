//
//  PopoverColorCell.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 20.01.2022.
//

import UIKit

final class ColorPickerCell: UICollectionViewCell {
    
    private enum Constants {
        static let cellViewCornerRadius = CGFloat(19)
    }
    
    private let cellView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(color: UIColor) {
        cellView.backgroundColor = color
    }
}

// MARK: - ConfigureView

private extension ColorPickerCell {
    
    func configureView() {
        contentView.addSubview(cellView)
        cellView.center = contentView.center
        cellView.layer.cornerRadius = Constants.cellViewCornerRadius
        cellView.clipsToBounds = true
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
