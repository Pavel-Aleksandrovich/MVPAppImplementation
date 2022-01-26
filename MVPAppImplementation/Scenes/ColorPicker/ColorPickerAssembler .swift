//
//  ColorPickerAssembler .swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 26.01.2022.
//

import UIKit

class ColorPickerAssembler {
    
    class func assembly(delegate: PopoverColorDelegate) -> UIViewController {
        
        let colors = ColorEntityImpl()
        let presenter = ColorPickerPresenterImpl(colors: colors)
        let view = ColorPickerViewController(presenter: presenter, delegate: delegate)
        
        return view
    }
}
