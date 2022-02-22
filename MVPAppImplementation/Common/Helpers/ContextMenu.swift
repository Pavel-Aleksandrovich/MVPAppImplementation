//
//  ContextMenu.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 22.02.2022.
//

import UIKit

enum ContextMenuActions {
    case edit
    case deleteConfirmation
    case showDetails
}

final class ContextMenu {
    
    public func contextMenuConfiguration(complitionHandler: @escaping (ContextMenuActions) -> ()) -> UIContextMenuConfiguration {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {suggestedActions in

            let showDetails = UIAction(title: "Show Details", image: UIImage(systemName: "square.and.arrow.up")) { action in
                complitionHandler(.showDetails)
            }

            let edit = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil")) { action in
                complitionHandler(.edit)
            }

            let deleteCancel = UIAction(title: "Cancel", image: UIImage(systemName: "xmark")) { action in }
            let deleteConfirmation = UIAction(title: "Delete", image: UIImage(systemName: "checkmark"), attributes: .destructive) { action in
                complitionHandler(.deleteConfirmation)
            }

            let delete = UIMenu(title: "Delete", image: UIImage(systemName: "trash"), children: [deleteCancel, deleteConfirmation])

            return UIMenu(title: "", children: [showDetails, edit, delete])
        }
    }
}
