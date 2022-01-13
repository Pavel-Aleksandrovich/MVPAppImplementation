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
    private let textField = UITextField()
    private var imageView = UIImageView()
    private var imageButton = UIButton()
    private let saveButton = UIBarButtonItem(title: Constants.SAVE_BUTTON, style: .done, target: self, action: #selector(saveButtonPressed))
    
    init(presenter: AddTaskPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
//        hideKeyboardWhenTappedAround()
        super.viewDidLoad()
        presenter.onViewAttached(view: self)
        presenter.setViewBackgrounColor()
        presenter.setViewTitle()
        textField.frame = CGRect(x: 25, y: 150, width: 200, height: 20)
        view.addSubview(textField)
        textField.placeholder = Constants.PLACEHOLDER
        textField.delegate = self
        isEnabled()
        navigationItem.rightBarButtonItem = saveButton
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 50, height: view.bounds.width - 50)
        view.addSubview(imageView)
        imageView.center = view.center
        imageView.backgroundColor = .black.withAlphaComponent(0.3)
        
        imageButton.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 50, height: view.bounds.width - 50)
        view.addSubview(imageButton)
        imageButton.center = view.center
        imageButton.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
    }
    
    @objc private func saveButtonPressed() {
        let addTask = TaskEntity(title: textField.text!)
        presenter.addButtonPressed(parametrs: addTask)
        presenter.popViewController(view: self)
    }
    
    @objc private func imageButtonTapped() {
        print("imageButtonTapped")
    }
}

// MARK: - AddTaskView

extension AddTaskViewController: AddTaskView {
    
    func isEnabled() {
        saveButton.isEnabled = presenter.isEnabledSaveButton(textField: textField.text!)
    }
    
    func setViewBackgrounColor(color: UIColor?) {
        view.backgroundColor = color
    }
    
    func setViewTitle(title: String?) {
        self.title = title
    }
}

// MARK: - UITextFieldDelegate

extension AddTaskViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        saveButton.isEnabled = presenter.isEnabledSaveButton(textField: text)
        
        return true
    }
}

extension UIViewController {
    
    func showAlert(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: false)
    }
}
