//
//  FontEntity.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 27.01.2022.
//

import Foundation

protocol FontEntity {
    var fonts: [String] { get }
    func getFontByIndex(index: Int) -> String
    func numberOfFonts() -> Int
}

struct FontEntityImpl: FontEntity {
    
    var fonts: [String] = ["Kailasa", "Marker Felt", "Snell Roundhand", "Times New Roman",
                           "Rockwell", "Noteworthy Light", "Kefa Regular"]
    
    func getFontByIndex(index: Int) -> String {
        return fonts[index]
    }
    
    func numberOfFonts() -> Int {
        return fonts.count
    }
}
