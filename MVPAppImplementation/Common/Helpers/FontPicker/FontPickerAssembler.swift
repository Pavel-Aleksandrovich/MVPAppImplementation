//
//  FontPickerAssembler.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 27.01.2022.
//

import UIKit

final class FontPickerAssembler {
    
    class func assembly(delegate: FontPickerDelegate, sourceView: UIButton) -> UIViewController {
        
        let fontEntity = FontEntityImpl()
        let presenter = FontPickerPresenterImpl(fontEntity: fontEntity)
        let view = FontPickerViewController(presenter: presenter, delegate: delegate, sourceView: sourceView)
        
        return view
    }
}
