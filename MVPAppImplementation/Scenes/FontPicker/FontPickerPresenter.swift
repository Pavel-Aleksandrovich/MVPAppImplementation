//
//  FontPickerPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 27.01.2022.
//

import Foundation

protocol FontPickerPresenter {
    func onViewAttached(view: FontPickerView)
    func numberOfFonts() -> Int
    func getFontByIndex(index: Int) -> String
}

protocol FontPickerView: AnyObject {
    
}

final class FontPickerPresenterImpl: FontPickerPresenter {
    
    private weak var view: FontPickerView?
    private let fontEntity: FontEntity
    
    init(fontEntity: FontEntity) {
        self.fontEntity = fontEntity
    }
    
    func onViewAttached(view: FontPickerView) {
        self.view = view
    }
    
    func numberOfFonts() -> Int {
        fontEntity.numberOfFonts()
    }
    
    func getFontByIndex(index: Int) -> String {
        fontEntity.getFontByIndex(index: index)
    }
}
