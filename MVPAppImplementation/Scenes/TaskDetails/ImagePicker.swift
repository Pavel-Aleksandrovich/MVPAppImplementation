//
//  ImagePicker.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 16.02.2022.
//
import UIKit

protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?)
}

class ImagePicker: NSObject {

    private weak var viewController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    init(viewController: UIViewController,
         delegate: ImagePickerDelegate) {
        super.init()

        self.viewController = viewController
        self.delegate = delegate
    }

    public func showChooseSourceTypeAlertController() {
        
        showAlertPhotoPicker(style: .actionSheet, title: "Shoose Image", message: nil, animated: false) { [ weak self ] (sourceType) in
            self?.showImagePickerController(sourceType: sourceType)
        }
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        
        delegate?.didSelect(image: image)
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        viewController?.present(imagePickerController, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ImagePicker:
    UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let image = editedImage.withRenderingMode(.alwaysOriginal)
            pickerController(picker, didSelect: image)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let image = originalImage.withRenderingMode(.alwaysOriginal)
            pickerController(picker, didSelect: image)
        }
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
