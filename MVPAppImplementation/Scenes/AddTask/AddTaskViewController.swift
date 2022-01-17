//
//  AddTaskViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    private enum Constants {
        static let PLACEHOLDER = "Enter the text"
        static let SAVE_BUTTON = "Save"
    }
    
    private var presenter: AddTaskPresenter!
    private let titleTextField = UITextField()
    private let descriptionTextView = UITextView()
    private var imageView = UIImageView()
    private let imageButton = UIButton()
    private let saveButton = UIBarButtonItem(title: Constants.SAVE_BUTTON, style: .done, target: self, action: #selector(saveButtonPressed))
    
    init(presenter: AddTaskPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        hideKeyboardWhenTappedAround()
        presenter.onViewAttached(view: self)
        
        titleTextField.frame = CGRect(x: 15, y: 110, width: view.bounds.width - 30, height: 30)
        view.addSubview(titleTextField)
        titleTextField.placeholder = Constants.PLACEHOLDER
        titleTextField.delegate = self
        titleTextField.layer.borderColor = UIColor.black.cgColor
        titleTextField.layer.borderWidth = CGFloat(1)
        
        descriptionTextView.frame = CGRect(x: 15, y: 150, width: view.bounds.width - 30, height: 200)
        view.addSubview(descriptionTextView)
        descriptionTextView.backgroundColor = .none
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = CGFloat(1)
        
        navigationItem.rightBarButtonItem = saveButton
        
        imageView.frame = CGRect(x: 15, y: view.bounds.width, width: view.bounds.width - 30, height: view.bounds.width - 30)
        view.addSubview(imageView)
//        imageView.center = view.center
        imageView.image = #imageLiteral(resourceName: "DefaultProfileImage.png")
        
        imageButton.frame = CGRect(x: 15, y: view.bounds.width, width: view.bounds.width - 30, height: view.bounds.width - 30)
        view.addSubview(imageButton)
        imageButton.layer.borderWidth = CGFloat(1)
//        imageButton.center = view.center
        imageButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
    }
    
    @objc private func saveButtonPressed() {
        
        if saveButton.tintColor == .gray.withAlphaComponent(0.6) {
            showShakeAnimation(textField: titleTextField)
        } else {
            
            // MARK: - Date
            
            let currentDate = Date()
            let formatter = DateFormatter()
//            formatter.timeStyle = .short
            formatter.dateStyle = .medium
            let dateTimeString = formatter.string(from: currentDate)
            
            let addTask = TaskEntity(title: titleTextField.text, image: imageView.image, currentDate: dateTimeString, descriptionText: descriptionTextView.text)
            presenter.addButtonPressed(parametrs: addTask)
            presenter.popViewController(navigationController: self.navigationController)
        }
    }
    
    @objc private func pickImage() {
        showChooseSourceTypeAlertController()
    }
}

// MARK: - AddTaskView

extension AddTaskViewController: AddTaskView {
    
    func setSaveButtonColor(color: UIColor) {
        saveButton.tintColor = color
    }
    
    func setViewBackgrounColor(color: UIColor?) {
        view.backgroundColor = color
    }
    
    func setViewTitle(title: String?) {
        self.title = title
    }
    
    func showChooseSourceTypeAlertController() {
        let photoLibraryAction = UIAlertAction(title: "Library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        showAlert(style: .actionSheet, title: "Pick Image From?", message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], animated: false)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension AddTaskViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        saveButton.tintColor = presenter.isEnabledSaveButton(text: text)
        
        return true
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension AddTaskViewController:
    UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageView.image = editedImage.withRenderingMode(.alwaysOriginal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = originalImage.withRenderingMode(.alwaysOriginal)
        }
        dismiss(animated: true, completion: nil)
    }
}


