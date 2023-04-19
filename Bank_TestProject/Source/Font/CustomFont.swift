//
//  CustomFont.swift
//  Bank_TestProject
//
//  Created by Дима Губеня on 15.04.2023.
//

import UIKit

enum CustomFont: String {
    case bold = "Sk-Modernist-Bold"
    case mono = "Sk-Modernist-Mono"
    case regular = "Sk-Modernist-Regular"
    
    func getFont(with size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}
