//
//  ColorPickerViewController.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 19.01.2022.
//

import UIKit

protocol ColorPickerDelegate: AnyObject {
    func pickColor(color: UIColor?)
}

final class ColorPickerViewController: UIViewController, ColorPickerView {
    
    private enum Constants {
        static let cellIdentifier = "cell"
    }
    
    private let presenter: ColorPickerPresenter!
    private let delegate: ColorPickerDelegate
    private let popoverView = UIView()
    private let layout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView!
    private let sourceView: UIButton
    
    init(presenter: ColorPickerPresenter, delegate: ColorPickerDelegate, sourceView: UIButton) {
        self.presenter = presenter
        self.delegate = delegate
        self.sourceView = sourceView
        
        super.init(nibName: nil, bundle: nil)
        self.preferredContentSize = CGSize(width: 260, height: 160)
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.permittedArrowDirections = .down
        self.popoverPresentationController?.sourceView = sourceView
        self.popoverPresentationController?.sourceRect = sourceView.bounds
        self.popoverPresentationController?.delegate = self
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

// MARK: - UICollectionViewDelegateFlowLayout

extension ColorPickerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (collectionView.frame.width - 12)/6, height: (collectionView.frame.width - 12)/6)
    }
}

// MARK: - UICollectionViewDelegate

extension ColorPickerViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let color = presenter.getColorByIndex(index: indexPath.item)
        delegate.pickColor(color: color)
    }
}

// MARK: - UICollectionViewDataSource

extension ColorPickerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfColors()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! ColorPickerCell
        
        let color = presenter.getColorByIndex(index: indexPath.item)
        cell.configure(color: color)
        
        return cell
    }
}

// MARK: - ConfigureView

private extension ColorPickerViewController {
    
    func configureView() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        layout.itemSize = CGSize(width: (collectionView.frame.width - 12)/6, height: (collectionView.frame.width - 12)/6)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        collectionView.register(ColorPickerCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        view.addSubview(collectionView)
        collectionView.center = view.center
        collectionView.frame = CGRect(x: 10, y: 10, width: 240, height: 140)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension ColorPickerViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
