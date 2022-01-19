//
//  PopoverViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 19.01.2022.
//

import UIKit

protocol PopoverColorDelegate: AnyObject {
    func colorPressed(color: UIColor?)
}

class PopoverColorViewController: UIViewController {
    
    weak var delegate: PopoverColorDelegate?
    let popoverView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        view.addSubview(popoverView)
        
        popoverView.backgroundColor = .white
        popoverView.center = view.center
        popoverView.layer.cornerRadius = 10
        popoverView.frame = CGRect(x: 10, y: 10, width: 280, height: 180)
        
        popoverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colorPressed)))
        
        
    }
    @objc private func colorPressed(_ press: UITapGestureRecognizer) {
        print("tap")
        delegate?.colorPressed(color: press.view?.backgroundColor)
    }
    
}
