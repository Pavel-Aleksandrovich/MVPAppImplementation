//
//  TaskDetailsPopupViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 21.01.2022.
//

import UIKit

class TaskDetailsPopupViewController: UIViewController {
    
    private let popupView = TaskDetailsPopupView()
    
    override func loadView() {
        view = popupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}

class TaskDetailsPopupView: UIView {
    
    let popupView = UIView()
    let closeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black.withAlphaComponent(0.3)
        
        addSubview(popupView)
        
        popupView.addSubview(closeButton)
        popupView.backgroundColor = .red
        closeButton.backgroundColor = .green
        popupView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popupView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            popupView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            popupView.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            popupView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150)
        ])
         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

