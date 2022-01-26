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

final class ColorPickerViewController: UIViewController, ColorPickerView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private enum Constants {
        static let cellIdentifier = "cell"
    }
    
    private let presenter: ColorPickerPresenter!
    private let delegateCell: PopoverColorDelegate?
    private let popoverView = UIView()
    private let layout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView!
    
    init(presenter: ColorPickerPresenter, delegate: PopoverColorDelegate) {
        self.presenter = presenter
        self.delegateCell = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(view: self)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        layout.itemSize = CGSize(width: (collectionView.frame.width - 12)/6, height: (collectionView.frame.width - 12)/6)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        
        collectionView.register(PopoverColorCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        view.addSubview(collectionView)
        collectionView.center = view.center
        collectionView.frame = CGRect(x: 10, y: 10, width: 240, height: 120)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (collectionView.frame.width - 12)/6, height: (collectionView.frame.width - 12)/6)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfColors()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! PopoverColorCell
        
        let color = presenter.getColorByIndex(index: indexPath.item)
        cell.cellView.backgroundColor = color
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)! as! PopoverColorCell
        delegateCell?.colorPressed(color: cell.cellView.backgroundColor)
    }
    
}
