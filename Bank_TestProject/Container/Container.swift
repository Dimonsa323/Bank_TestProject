//
//  Container.swift
//  Bank_TestProject
//
//  Created by Дима Губеня on 19.04.2023.
//

import Foundation

struct Container {

    let coreDataService: CoreDataServiceProtocol

    static func createContainer() -> Container {
        let coreDataService: CoreDataServiceProtocol = CoreDataService()

        return Container(coreDataService: coreDataService)
    }
}
