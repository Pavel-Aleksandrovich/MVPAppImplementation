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

class PopoverColorViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private enum Constants {
        static let cellIdentifier = "cell"
    }
    
    weak var delegate: PopoverColorDelegate?
    let popoverView = UIView()
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView?
    let colorArray: [UIColor] = [ .black, .blue, .brown, .cyan, .darkGray, .gray, .green, .lightGray, .link, .magenta, .orange, .purple, .red, .systemIndigo, .white, .yellow, .systemTeal, .systemPink]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
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
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! PopoverColorCell
        
        cell.cellView.backgroundColor = colorArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)! as! PopoverColorCell
        delegate?.colorPressed(color: cell.cellView.backgroundColor)
    }
    
}
