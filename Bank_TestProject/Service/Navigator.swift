//
//  Navigator.swift
//  Bank_TestProject
//
//  Created by Дима Губеня on 17.04.2023.
//

import UIKit

protocol NavigatorProtocol {
    func showCardVC() -> UIViewController
}

class Navigator: NavigatorProtocol {
    
    private let assembler: Assembler = Assembler()
    
    func showCardVC() -> UIViewController {
        assembler.createCardVC(navigator: self)
    }
}
