//
//  ColorPickerPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 26.01.2022.
//

import UIKit

protocol ColorPickerPresenter {
    func onViewAttached(view: ColorPickerView)
    func numberOfColors() -> Int
    func getColorByIndex(index: Int) -> UIColor
}

protocol ColorPickerView: AnyObject {
    
}

final class ColorPickerPresenterImpl: ColorPickerPresenter {
    
    private weak var view: ColorPickerView?
    private let colorEntity: ColorEntity
    
    init(colors: ColorEntity){
        self.colorEntity = colors
    }
    
    func onViewAttached(view: ColorPickerView) {
        self.view = view
    }
    
    func numberOfColors() -> Int {
        return colorEntity.numberOfColors()
    }
    
    func getColorByIndex(index: Int) -> UIColor {
        return colorEntity.getColorByIndex(index: index)
    }
}
