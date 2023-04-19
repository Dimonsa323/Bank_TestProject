//
//  Card.swift
//  Bank_TestProject
//
//  Created by Дима Губеня on 19.04.2023.
//

import Foundation

class Bank {
    let title: String
    let subTitle: String
    var status: CardStatus

    init(title: String, subTitle: String, status: CardStatus) {
        self.title = title
        self.subTitle = subTitle
        self.status = status
    }

    enum CardStatus {
        case locked
        case unlocked
        case unlocking

        var text: String {
            switch self {
            case .locked:
                return "Locked"
            case .unlocked:
                return "Unlocked"
            case .unlocking:
                return "Unlocking..."
            }
        }

        var mainImageName: String {
            switch self {
            case .locked:
                return "icon_locked_status"
            case .unlocked:
                return "icon_unlocked_status"
            case .unlocking:
                return "icon_unlocking_status"
            }
        }

        var cardImageName: String {
            switch self {
            case .locked:
                return "icon_locked_door"
            case .unlocked:
                return "icon_unlocked_door"
            case .unlocking:
                return ""
            }
        }

        var opacity: Float {
            switch self {
            case .locked:
                return 1
            case .unlocking:
                return 0.17
            case .unlocked:
                return 0.5
            }
        }

        var unlockIsEnable: Bool {
            switch self {
            case .locked:
                return true
            case .unlocking:
                return false
            case .unlocked:
                return false
            }
        }
    }

    func changeCardStatus() {
        switch status {
        case .locked:
            status = .unlocked
        case .unlocked:
            status = .unlocking
        case .unlocking:
            status = .locked
        }
    }
}

extension Bank {
    static func getMockDate() -> [Bank] {
        let count = Int.random(in: 1...20)
        let cards = (0...count).map { _ in
            let randomTitle = ["Front Сard", "Home Сard", "Work Card"].randomElement() ?? "Front Card"
            let randomSubTitle = ["Front", "Home", "Work"].randomElement() ?? "Front"
            let status = Bank.CardStatus.locked

            return Bank(title: randomTitle, subTitle: randomSubTitle, status: status)
        }

        return cards
    }
}

