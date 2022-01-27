//
//  AddTaskViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

class AddTaskViewController: UIViewController, ColorPickerDelegate {
    
    private enum Constants {
        static let placeholder = "Enter the text"
        static let saveButton = "Save"
    }
    
    private let presenter: AddTaskPresenter!
    private let titleTextField = UITextField()
    private let descriptionTextView = UITextView()
    private let imageView = UIImageView()
    private let imageButton = UIButton()
    private let saveButton = UIBarButtonItem(title: Constants.saveButton, style: .done, target: self, action: #selector(saveButtonPressed))
    private let colorPickerButton = UIButton()
    private let fontPickerButton = UIButton()
    private let datePickerButton = UIButton()
    private let datePicker = UIDatePicker()
    private let dateFormatter = DateFormatter()
    
    init(presenter: AddTaskPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = saveButton
        
//                hideKeyboardWhenTappedAround()
        presenter.onViewAttached(view: self)
        
        // titleTextField
        
        titleTextField.frame = CGRect(x: 15, y: 110, width: view.bounds.width - 30, height: 30)
        view.addSubview(titleTextField)
        titleTextField.placeholder = Constants.placeholder
        titleTextField.delegate = self
        titleTextField.layer.borderColor = UIColor.black.cgColor
        titleTextField.layer.borderWidth = CGFloat(1)
        
        // descriptionTextView
         
        descriptionTextView.frame = CGRect(x: 15, y: 150, width: view.bounds.width - 30, height: 200)
        view.addSubview(descriptionTextView)
        descriptionTextView.backgroundColor = .none
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = CGFloat(1)
        descriptionTextView.font = .systemFont(ofSize: 15, weight: .light)
        
        imageView.frame = CGRect(x: 15, y: view.bounds.width, width: view.bounds.width - 30, height: view.bounds.width - 30)
        view.addSubview(imageView)
        //        imageView.center = view.center
        imageView.image = #imageLiteral(resourceName: "DefaultProfileImage.png")
        
        imageButton.frame = CGRect(x: 15, y: view.bounds.width, width: view.bounds.width - 30, height: view.bounds.width - 30)
        view.addSubview(imageButton)
        imageButton.layer.borderWidth = CGFloat(1)
        //        imageButton.center = view.center
        imageButton.addTarget(self, action: #selector(showPickImageFromGallery), for: .touchUpInside)
        
        // colorPopoverButton
        
        view.addSubview(colorPickerButton)
        colorPickerButton.backgroundColor = .magenta
        colorPickerButton.frame = CGRect(x: view.bounds.width - 100, y: view.bounds.width - 25, width: 80, height: 25)
        colorPickerButton.addTarget(self, action: #selector(showColorPickerPopover), for: .touchUpInside)
        
        // fontPickerButton
        
        view.addSubview(fontPickerButton)
        fontPickerButton.backgroundColor = .red
        fontPickerButton.frame = CGRect(x: 10, y: view.bounds.width - 25, width: 80, height: 25)
        fontPickerButton.addTarget(self, action: #selector(showFontPickerPopover), for: .touchUpInside)
        
        // datePickerButton
        
        view.addSubview(datePickerButton)
        datePickerButton.backgroundColor = .link
        datePickerButton.frame = CGRect(x: 100, y: view.bounds.width - 25, width: 80, height: 25)
//        datePickerButton.addTarget(self, action: #selector(popUp), for: .touchUpInside)
        
        view.addSubview(datePicker)
        datePicker.center = view.center
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
        datePicker.preferredDatePickerStyle = .compact
        datePicker.sizeToFit()
    }
    
    @objc private func showPickImageFromGallery() {
        presenter.setDataForAlertPhotoPicker()
    }
    
    // MARK: - Save Button Pressed
    
    @objc private func saveButtonPressed() {
        
        if saveButton.tintColor == .gray.withAlphaComponent(0.6) {
            showShakeAnimation(textField: titleTextField)
        } else {
            
            // MARK: - Date
            
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            let dateTimeString = formatter.string(from: currentDate)
            
            let addTask = TaskEntity(title: titleTextField.textOrEmptyString,
                                     image: imageView.textOrEmptyString,
                                     currentDate: dateTimeString,
                                     descriptionText: descriptionTextView.textOrEmptyString,
                                     color: colorPickerButton.textOrEmptyString,
                                     date: dateFormatter.string(from: datePicker.date))
            
            presenter.addTaskButtonPressed(task: addTask)
            presenter.popViewController(navigationController: self.navigationController)
            
        }
    }
    
    @objc func showDatePickerPopover() {
        let datePickerPopoverViewController = DatePickerPopoverViewController()
        datePickerPopoverViewController.delegate = self
        datePickerPopoverViewController.modalPresentationStyle = .popover
        datePickerPopoverViewController.popoverPresentationController?.delegate = self
        
        let datePicker = datePickerPopoverViewController.popoverPresentationController
        datePicker?.permittedArrowDirections = .down
        datePicker?.sourceView = datePickerButton
        datePicker?.sourceRect = datePickerButton.bounds
        
        datePickerPopoverViewController.preferredContentSize = CGSize(width: 260, height: 140)
        
        present(datePickerPopoverViewController, animated: true, completion: nil)
    }
    
    @objc func showFontPickerPopover() {
        presenter.presentFontPicker(viewController: self, sourceView: fontPickerButton, delegate: self)
    }
    
    @objc func showColorPickerPopover() {
        presenter.presentColorPicker(viewController: self, sourceView: colorPickerButton, delegate: self)
    }
    
    func pickColor(color: UIColor?) {
        colorPickerButton.backgroundColor = color
    }
}

// MARK: - Date Picker Popover Delegate

extension AddTaskViewController: DatePickerPopoverDelegate {
}

// MARK: - Font Picker Popover Delegate

extension AddTaskViewController: FontPickerDelegate {
    
    func setFont(font: String) {
        titleTextField.font = UIFont.init(name: font, size: 25)
        fontPickerButton.setTitle(font, for: .normal)
    }
}

// MARK: - Color Picker Popover Delegate

extension AddTaskViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
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
    
    func showChooseSourceTypeAlertController(style: UIAlertController.Style,
                                             title: String?,
                                             message: String?,
                                             animated: Bool) {
        
        showAlertPhotoPicker(style: style, title: title, message: message, animated: animated) { [ weak self ] (sourceType) in
            self?.showImagePickerController(sourceType: sourceType)
        }
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


