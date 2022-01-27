//
//  FontPickerPopoverViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 20.01.2022.
//

import UIKit

protocol FontPickerDelegate: AnyObject {
    func setFont(font: String)
}

class FontPickerViewController: UIViewController, FontPickerView {
    
    enum Constants {
        static let numberOfComponents = 1
    }
    
    private weak var delegate: FontPickerDelegate?
    private let presenter: FontPickerPresenter!
    private let fontPicker = UIPickerView()
    private let sourceView: UIButton
    
    init(presenter: FontPickerPresenter, delegate: FontPickerDelegate, sourceView: UIButton) {
        self.presenter = presenter
        self.delegate = delegate
        self.sourceView = sourceView
        super.init(nibName: nil, bundle: nil)
        
        self.preferredContentSize = CGSize(width: 260, height: 140)
        self.popoverPresentationController?.permittedArrowDirections = .down
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.delegate = self
        self.popoverPresentationController?.sourceView = sourceView
        self.popoverPresentationController?.sourceRect = sourceView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(view: self)
        configureView()
    }
}

// MARK: - UIPickerViewDataSource

extension FontPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        Constants.numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter.numberOfFonts()
    }
    
}

// MARK: - UIPickerViewDelegate

extension FontPickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let result = presenter.getFontByIndex(index: row)
        delegate?.setFont(font: result)
        return result
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension FontPickerViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - ConfigureView

private extension FontPickerViewController {
    
    func configureView() {
        view.addSubview(fontPicker)
        fontPicker.center = view.center
        fontPicker.delegate = self
        fontPicker.dataSource = self
        fontPicker.frame = CGRect(x: 10, y: 10, width: 240, height: 120)
    }
}
