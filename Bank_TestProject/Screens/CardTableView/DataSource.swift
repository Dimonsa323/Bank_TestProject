//
//  DataSource.swift
//  Bank_TestProject
//
//  Created by Дима Губеня on 19.04.2023.
//

import Foundation

// MARK: - CardsTableViewDataSourceProtocol

protocol CardsTableViewDataSourceProtocol {
    var countCards: Int { get }

    func getCard(with row: Int) -> Bank
    func changeStatusCard(with row: Int)
    func getMockDate()
}

// MARK: - CardsData: CardsTableViewDataSourceProtocol

class BankData: CardsTableViewDataSourceProtocol {
    private var cards: [Bank] = []

    var countCards: Int {
        cards.count
    }
    
    func getMockDate() {
        cards = Bank.getMockDate()
    }

    func getCard(with row: Int) -> Bank {
        cards[row]
    }

    func changeStatusCard(with row: Int) {
        cards[row].changeCardStatus()
    }
}
