//
//  AddTaskViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

class TaskDetailsViewController: UIViewController, ColorPickerDelegate, UITextViewDelegate {
    
    private enum Constants {
        static let placeholder = "Enter the text"
        static let saveButton = "Save"
    }
    
    private let mainView: TaskDetailsView
    private let presenter: TaskDetailsPresenter
    private let titleTextField = UITextField()
    private let descriptionTextView = UITextView()
    private let imageView = UIImageView()
    private let saveButton = UIBarButtonItem(title: Constants.saveButton, style: .done, target: self, action: #selector(saveButtonTapped))
    private let imageButton = UIButton()
    private let colorPickerButton = UIButton()
    private let scrollView = UIScrollView()
    private let fontPickerTextField = UITextField()
    private let datePickerTextField = UITextField()
    private let hStackView = UIStackView()
    private var scrollViewLayoutConstraint: NSLayoutConstraint?
    private var keyboardHelper: Keyboard?
    private var datePicker: DatePicker?
    private var fontPicker: FontPicker?
    private var imagePicker: ImagePicker?
    
    var saveTaskButtonTappedHandler: ((TaskEntity) -> ())?
    var colorPickerButtonTappedHandler: ((UIButton) -> ())?
    
    init(presenter: TaskDetailsPresenter) {
        mainView = TaskDetailsViewImpl()
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        //        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(controller: self, view: mainView)
        configureAppearance()
        createSaveButton()
        configureView()
        configureLayout()
        configureActions()
        registerKeyboardNotification()
        createDatePicker()
        createFontPicker()
    }
    
    private func createSaveButton() {
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func configureAppearance() {
        navigationItem.largeTitleDisplayMode = .never
        //                hideKeyboardWhenTappedAround()
        
        fontPickerTextField.textAlignment = .center
        fontPickerTextField.sizeToFit()
        fontPickerTextField.placeholder = "Pick font"
        fontPickerTextField.borderStyle = .roundedRect
        
        datePickerTextField.textAlignment = .center
        datePickerTextField.placeholder = "Pick date"
        datePickerTextField.borderStyle = .roundedRect
        
        hStackView.axis = .horizontal
        hStackView.alignment = .center
        hStackView.distribution = .fillProportionally
        hStackView.spacing = 16
        
        scrollView.backgroundColor = .systemBackground
        
        titleTextField.placeholder = Constants.placeholder
        titleTextField.delegate = self
        titleTextField.borderStyle = .roundedRect
        
        descriptionTextView.backgroundColor = .none
        descriptionTextView.layer.borderColor = UIColor.systemGray5.cgColor
        descriptionTextView.layer.borderWidth = CGFloat(0.8)
        descriptionTextView.layer.cornerRadius = 7
        descriptionTextView.font = .systemFont(ofSize: 15, weight: .light)
        
        imageView.image = #imageLiteral(resourceName: "DefaultProfileImage.png")
        imageButton.layer.borderWidth = CGFloat(1)
        
        colorPickerButton.backgroundColor = .magenta
    }
    
    private func createDatePicker() {
        datePicker = DatePicker(textField: datePickerTextField, viewController: self)
    }
    
    private func createFontPicker() {
        fontPicker = FontPicker(viewController: self, textField: fontPickerTextField, complitionHandler: { [ weak self ] font, size in
            self?.titleTextField.font = UIFont(name: font, size: size)
        })
    }
    
    private func configureActions() {
        configureColorPickerButtonAction()
        configureImageButtonAction()
    }
    
    private func configureColorPickerButtonAction() {
        colorPickerButton.addTarget(self, action: #selector(showColorPickerPopover), for: .touchUpInside)
    }
    
    private func configureImageButtonAction() {
        imageButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
    }
    
    @objc func showColorPickerPopover() {
        colorPickerButtonTappedHandler?(colorPickerButton)
    }
    
    @objc private func showImagePicker() {
        imagePicker = ImagePicker(viewController: self, complitionHandler: { [ weak self ] image in
            self?.imageView.image = image
        })
    }
    
    @objc private func saveButtonTapped() {
        
        if saveButton.tintColor == .gray.withAlphaComponent(0.6) {
            showShakeAnimation(textField: titleTextField)
        } else {
            let currentDate = createCurrentDate()
            
            saveTask(currentDate: currentDate)
        }
    }
    
    private func saveTask(currentDate: String) {
        
        let addTask = TaskEntity(title: titleTextField.textOrEmptyString,
                                 image: imageView.image ?? #imageLiteral(resourceName: "DefaultProfileImage.png"),
                                 currentDate: currentDate,
                                 descriptionText: descriptionTextView.textOrEmptyString,
                                 color: colorPickerButton.textOrEmptyString,
                                 date: datePickerTextField.text!)
        
        saveTaskButtonTappedHandler?(addTask)
    }
    
    private func createCurrentDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateTimeString = formatter.string(from: currentDate)
        
        return dateTimeString
    }
    
    func pickColor(color: UIColor?) {
        colorPickerButton.backgroundColor = color
    }
}

// MARK: - AddTaskView

extension TaskDetailsViewController: TaskDetailsController {
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
}

private extension TaskDetailsViewController {
    
    func registerKeyboardNotification() {
        keyboardHelper = Keyboard( complitionHandler: { [ weak self ] moveKeyboard, keyboardFrame in
            switch moveKeyboard {
            case .keyboardWillHide:
                self?.keyboardWillHide()
            case .keyboardWillShow:
                self?.keyboardWillShow(keyboardFrame: keyboardFrame)
            }
        })
    }
    
    func keyboardWillShow(keyboardFrame: CGRect) {
        if scrollViewLayoutConstraint?.constant == 0 {
            let keyboardTop = keyboardFrame.height
            scrollViewLayoutConstraint?.constant = -keyboardTop
            scrollView.contentOffset = CGPoint(x: 0, y: keyboardTop)
        }
    }
    
    func keyboardWillHide() {
        if scrollViewLayoutConstraint?.constant != 0 {
            scrollViewLayoutConstraint?.constant = 0
            scrollView.contentOffset = CGPoint.zero
        }
    }
    
    func configureView() {
        
        [scrollView, titleTextField, descriptionTextView, imageView, colorPickerButton, imageButton, fontPickerTextField, datePickerTextField, hStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(hStackView)
        scrollView.addSubview(titleTextField)
        scrollView.addSubview(imageView)
        scrollView.addSubview(imageButton)
        scrollView.addSubview(colorPickerButton)
        scrollView.addSubview(descriptionTextView)
        hStackView.addArrangedSubview(datePickerTextField)
        hStackView.addArrangedSubview(fontPickerTextField)
    }
    
    func configureLayout() {
        scrollViewLayoutConstraint = scrollView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor, constant: 0)
        scrollViewLayoutConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            titleTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            titleTextField.heightAnchor.constraint(equalToConstant: 30),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 200),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            hStackView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            hStackView.heightAnchor.constraint(lessThanOrEqualToConstant: 30),
            hStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            hStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            datePickerTextField.centerYAnchor.constraint(
                equalTo: hStackView.centerYAnchor),
            datePickerTextField.leadingAnchor.constraint(
                equalTo: hStackView.leadingAnchor),
            
            fontPickerTextField.centerYAnchor.constraint(
                equalTo: hStackView.centerYAnchor),
            fontPickerTextField.trailingAnchor.constraint(
                equalTo: hStackView.trailingAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            imageButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            imageButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            imageButton.topAnchor.constraint(equalTo: imageView.topAnchor),
            imageButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
        ])
    }
}
