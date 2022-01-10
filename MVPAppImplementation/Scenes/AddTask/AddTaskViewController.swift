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
    private let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    private let buttonSave = UIBarButtonItem(title: Constants.SAVE_BUTTON, style: .done, target: self, action: #selector(saveButtonPressed))
    
    init(presenter: AddTaskPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(view: self)
        presenter.setViewBackgrounColor()
        presenter.setViewTitle()
        view.addSubview(textField)
        textField.center = view.center
        textField.placeholder = Constants.PLACEHOLDER
        textField.backgroundColor = .green
        textField.delegate = self
        
        navigationItem.rightBarButtonItem = buttonSave
        if textField.text!.isEmpty{
                buttonSave.isEnabled = false
            }
    }
    
    @objc private func saveButtonPressed() {
        let addTask = TaskEntity(title: textField.text!)
        presenter.addButtonPressed(parametrs: addTask)
    }
}

extension AddTaskViewController: AddTaskView {
    func setViewBackgrounColor(color: UIColor?) {
        view.backgroundColor = color
    }
    
    func setViewTitle(title: String?) {
        self.title = title
    }
}

extension AddTaskViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty{
            buttonSave.isEnabled = true
        } else {
            buttonSave.isEnabled = false
        }
        return true
    }
}
