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
    private let colorPickerButton = UIButton()
    private let saveButton = UIButton()
    private var behavior: ButtonEnablingBehavior!
    private let scrollView = UIScrollView()
    private let fontPickerTextField = UITextField()
    private let datePickerTextField = UITextField()
    private let vStackView = UIStackView()
    private var keyboardMove: Keyboard?
    private var datePicker: DatePicker?
    private var fontPicker: FontPicker?
    private var imagePicker: ImagePicker?
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy, h:mm a"
        return dateFormatter
    }()
    
    var saveTaskButtonTappedHandler: ((Task) -> ())?
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
        configureAppearance()
        presenter.onViewAttached(controller: self, view: mainView)
        configureView()
        configureLayout()
        configureActions()
        hideOrShowKeyboard()
        createDatePicker()
        createFontPicker()
        configureBehaviorSaveButton()
    }
    
    private func configureBehaviorSaveButton() {
        behavior = ButtonEnablingBehavior(textFields: [titleTextField], onChange: { enable in
            if enable {
                self.configureSaveButtonAction()
            } else {
                self.configureSaveButtonAnimation()
            }
        })
    }
    
    private func configureAppearance() {
        navigationItem.largeTitleDisplayMode = .never
        
        hideKeyboardWhenTappedAround()
        
        fontPickerTextField.textAlignment = .center
        fontPickerTextField.placeholder = "Pick font"
        fontPickerTextField.borderStyle = .roundedRect
        
        datePickerTextField.textAlignment = .center
        datePickerTextField.placeholder = "Pick date"
        datePickerTextField.borderStyle = .roundedRect
        
        vStackView.axis = .vertical
        vStackView.alignment = .center
        vStackView.distribution = .fillProportionally
        vStackView.spacing = 16
        
        scrollView.backgroundColor = .systemBackground
        
        titleTextField.placeholder = Constants.placeholder
        titleTextField.delegate = self
        titleTextField.borderStyle = .roundedRect
        
        descriptionTextView.backgroundColor = .none
        descriptionTextView.layer.borderColor = UIColor.systemGray5.cgColor
        descriptionTextView.layer.borderWidth = CGFloat(0.8)
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.font = .systemFont(ofSize: 15, weight: .light)
        
        imageView.image = #imageLiteral(resourceName: "DefaultProfileImage.png")
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds  = true
        imageView.isUserInteractionEnabled = true
        
        saveButton.layer.borderColor = UIColor.systemBlue.cgColor
        saveButton.layer.borderWidth = CGFloat(3)
        saveButton.layer.cornerRadius = 30
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        
        colorPickerButton.layer.cornerRadius = 5
        colorPickerButton.setTitle("Pick color", for: .normal)
        colorPickerButton.setTitleColor(.systemGray3, for: .normal)
        colorPickerButton.layer.borderColor = UIColor.systemGray5.cgColor
        colorPickerButton.layer.borderWidth = CGFloat(0.8)
    }
    
    private func createDatePicker() {
        datePicker = DatePicker(textField: datePickerTextField, viewController: self)
    }
    
    private func createFontPicker() {
        fontPicker = FontPicker(viewController: self, textField: fontPickerTextField, complitionHandler: { [ weak self ] font, size in
            self?.titleTextField.font = UIFont(name: font, size: size)
            self?.fontPickerTextField.font = UIFont(name: font, size: size)
        })
    }
    
    private func configureActions() {
        configureColorPickerButtonAction()
        configureImageViewAction()
    }
    
    private func configureImageViewAction() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        imageView.addGestureRecognizer(gesture)
    }
    
    private func configureSaveButtonAction() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.alpha = 1
    }
    
    private func configureSaveButtonAnimation() {
        saveButton.addTarget(self, action: #selector(showShakeAnimation), for: .touchUpInside)
        saveButton.alpha = 0.2
    }
    
    private func configureColorPickerButtonAction() {
        colorPickerButton.addTarget(self, action: #selector(showColorPickerPopover), for: .touchUpInside)
    }
    
    @objc func pickImage(_ sender: UITapGestureRecognizer) {
        imagePicker = ImagePicker(viewController: self, complitionHandler: { [ weak self ] image in
            self?.imageView.image = image
        })
    }
    
    @objc func showColorPickerPopover() {
        colorPickerButtonTappedHandler?(colorPickerButton)
    }
    
    @objc private func showShakeAnimation() {
        createShakeAnimation(textField: titleTextField)
    }
    
    @objc private func saveButtonTapped() {
        guard let text = titleTextField.text else { return }
        if !text.isEmpty {
            let currentDate = dateFormatter.date(from: datePickerTextField.text ?? "")
            
            let task = Task(color: "", currentDate: currentDate ?? Date(), descriptionText: descriptionTextView.text, fontText: "", image: imageView.image ?? #imageLiteral(resourceName: "DefaultProfileImage"), title: titleTextField.text!)
            
            saveTaskButtonTappedHandler?(task)
        }
    }
    
    func pickColor(color: UIColor?) {
        colorPickerButton.backgroundColor = color
        
        saveButton.setTitleColor(color, for: .normal)
        saveButton.layer.borderColor = color?.cgColor
    }
}

// MARK: - AddTaskView

extension TaskDetailsViewController: TaskDetailsController {
    
    func configure(task: TaskEntity) {
        titleTextField.text = task.title
        descriptionTextView.text = task.descriptionText
        
        let dateString = dateFormatter.string(from: task.currentDate ?? Date())
        datePickerTextField.text = dateString
        
        guard let imageData = task.image else {return}
        imageView.image = UIImage(data: imageData)
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
}

private extension TaskDetailsViewController {
    
    func hideOrShowKeyboard() {
        keyboardMove = Keyboard(scrollView: scrollView, viewController: self)
    }
    
    func configureView() {
        [scrollView, titleTextField, descriptionTextView, imageView, colorPickerButton, fontPickerTextField, datePickerTextField, vStackView, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(vStackView)
        scrollView.addSubview(saveButton)
        scrollView.addSubview(titleTextField)
        scrollView.addSubview(imageView)
        scrollView.addSubview(descriptionTextView)
        vStackView.addArrangedSubview(datePickerTextField)
        vStackView.addArrangedSubview(fontPickerTextField)
        vStackView.addArrangedSubview(colorPickerButton)
    }
    
    func configureLayout() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            titleTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            descriptionTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            vStackView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            vStackView.heightAnchor.constraint(lessThanOrEqualToConstant: 150),
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            datePickerTextField.widthAnchor.constraint(
                equalTo: vStackView.widthAnchor),
            datePickerTextField.heightAnchor.constraint(equalTo: titleTextField.heightAnchor),
            
            fontPickerTextField.widthAnchor.constraint(
                equalTo: vStackView.widthAnchor),
            fontPickerTextField.heightAnchor.constraint(
                equalTo: datePickerTextField.heightAnchor),
            
            colorPickerButton.widthAnchor.constraint(
                equalTo: vStackView.widthAnchor),
            colorPickerButton.heightAnchor.constraint(
                equalTo: datePickerTextField.heightAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: vStackView.bottomAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            saveButton.heightAnchor.constraint(equalToConstant: 60),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
}
