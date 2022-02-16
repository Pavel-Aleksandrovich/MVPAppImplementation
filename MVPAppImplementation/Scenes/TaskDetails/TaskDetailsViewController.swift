//
//  AddTaskViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

class TaskDetailsViewController: UIViewController, ColorPickerDelegate {
    
    private enum Constants {
        static let placeholder = "Enter the text"
        static let saveButton = "Save"
    }
    
    private let presenter: TaskDetailsPresenter!
    private let titleTextField = UITextField()
    private let descriptionTextView = UITextView()
    private let imageView = UIImageView()
    private let imageButton = UIButton()
    private let saveButton = UIBarButtonItem(title: Constants.saveButton, style: .done, target: self, action: #selector(saveButtonTapped))
    private let colorPickerButton = UIButton()
    private let fontPickerButton = UIButton()
    private let datePickerButton = UIButton()
    private let datePicker = UIDatePicker()
    
    private lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker(viewController: self, delegate: self)
        return imagePicker
    }()
    
    var saveTaskButtonTappedHandler: ((TaskEntity) -> ())?
    var colorPickerButtonTappedHandler: ((UIButton) -> ())?
    var fontPickerButtonTappedHandler: ((UIButton, TaskDetailsViewController) -> ())?
    
    init(presenter: TaskDetailsPresenter) {
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
        datePickerButton.backgroundColor = .black
        datePickerButton.frame = CGRect(x: 100, y: view.bounds.width - 25, width: 80, height: 25)
        datePickerButton.addTarget(self, action: #selector(calendarPicker), for: .touchUpInside)
        
        // datePicker
        
        view.addSubview(datePicker)
        datePicker.center = view.center
        
        datePicker.preferredDatePickerStyle = .compact
        datePicker.sizeToFit()
    }
    
    @objc private func calendarPicker() {
        let calendar = CalendarPickerViewController(baseDate: Date()) { Date in
            print("\(Date)")
        }
        present(calendar, animated: true)
    }
    
    @objc private func showPickImageFromGallery() {
        imagePicker.showChooseSourceTypeAlertController()
    }
    
    // MARK: - Save Button Pressed
    
    @objc private func saveButtonTapped() {
        
        if saveButton.tintColor == .gray.withAlphaComponent(0.6) {
            showShakeAnimation(textField: titleTextField)
        } else {
            let currentDate = createCurrentDate()
            let date = createDate()
            
            let addTask = TaskEntity(title: titleTextField.textOrEmptyString,
                                     image: imageView.image ?? #imageLiteral(resourceName: "DefaultProfileImage.png"),
                                     currentDate: currentDate,
                                     descriptionText: descriptionTextView.textOrEmptyString,
                                     color: colorPickerButton.textOrEmptyString,
                                     date: date)
            
            saveTaskButtonTappedHandler?(addTask)
        }
    }
    
    private func createDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
        
        return dateFormatter.string(from: datePicker.date)
    }
    
    private func createCurrentDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateTimeString = formatter.string(from: currentDate)
        
        return dateTimeString
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
        fontPickerButtonTappedHandler?(fontPickerButton, self)
    }
    
    @objc func showColorPickerPopover() {
        colorPickerButtonTappedHandler?(colorPickerButton)
    }
    
    func pickColor(color: UIColor?) {
        colorPickerButton.backgroundColor = color
    }
}

// MARK: - ImagePickerDelegate

extension TaskDetailsViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        imageView.image = image
    }
}

extension TaskDetailsViewController: DatePickerPopoverDelegate {
}

// MARK: - Font Picker Popover Delegate

extension TaskDetailsViewController: FontPickerDelegate {
    
    func setFont(font: String) {
        titleTextField.font = UIFont.init(name: font, size: 25)
        fontPickerButton.setTitle(font, for: .normal)
    }
}
// MARK: - Color Picker Popover Delegate

extension TaskDetailsViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
// MARK: - AddTaskView

extension TaskDetailsViewController: TaskDetailsView {
    
    func configure(task: TaskEntity) {
        titleTextField.text = task.titleText
        descriptionTextView.text = task.descriptionText
        imageView.image = task.image
        colorPickerButton.backgroundColor = task.color
    }
    
    func setSaveButtonColor(color: UIColor) {
        saveButton.tintColor = color
    }
    
    func setViewBackgrounColor(color: UIColor?) {
        view.backgroundColor = color
    }
    
    func setViewTitle(title: String?) {
        self.title = title
    }
}

// MARK: - UITextFieldDelegate

extension TaskDetailsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        saveButton.tintColor = presenter.isEnabledSaveButton(text: text)
        
        return true
    }
}
