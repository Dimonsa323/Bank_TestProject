//
//  Assembler.swift
//  Bank_TestProject
//
//  Created by Дима Губеня on 17.04.2023.
//

import UIKit

class Assembler {
    
    private let container: Container = Container.createContainer()
    
    func createCardVC(navigator: NavigatorProtocol) -> UIViewController {
        let cardVC = CardsViewController(navigator: navigator)
        
        return cardVC
    }
}
