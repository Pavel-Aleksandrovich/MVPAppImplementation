//
//  ImagePicker.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 16.02.2022.
//
import UIKit

final class ImagePicker: NSObject {

    private weak var viewController: UIViewController?
    private let complitionHandler: (UIImage) -> ()
    
    init(viewController: UIViewController,
         complitionHandler: @escaping (UIImage) -> ()) {
        self.viewController = viewController
        self.complitionHandler = complitionHandler
        super.init()
        showChooseSourceTypeAlertController()
    }

    private func showChooseSourceTypeAlertController() {
        
        showAlertPhotoPicker(style: .actionSheet, title: "Shoose Image", message: nil, animated: false) { [ weak self ] (sourceType) in
            self?.showImagePickerController(sourceType: sourceType)
        }
    }
    
    private func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        viewController?.present(imagePickerController, animated: true)
    }
}

extension ImagePicker: UINavigationControllerDelegate,
                       UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let image = editedImage.withRenderingMode(.alwaysOriginal)
            complitionHandler(image)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let image = originalImage.withRenderingMode(.alwaysOriginal)
            complitionHandler(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

private extension ImagePicker {
    
    func showAlertPhotoPicker(style: UIAlertController.Style, title: String?, message: String?, animated: Bool,
                              closure: @escaping (UIImagePickerController.SourceType) -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let photoLibraryAction = UIAlertAction(title: "Library", style: .default) {_ in
            closure(.photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) {_ in
            closure(.camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        
        viewController?.present(alert, animated: animated)
    }
}
