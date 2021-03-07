//
//  Statement.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import Foundation

class Statement: Decodable {
    var items: [StatementItem]?
}

enum TransactionType: String, Decodable {
    case transferIn = "TRANSFERIN"
    case transferOut = "TRANSFEROUT"
    case pixCashIn = "PIXCASHIN"
    case pixCashOut = "PIXCASHOUT"
    case bankSlipCashIn = "BANKSLIPCASHIN"
    case bankSlipCashOut = "BANKSLIPCASHOUT"
}

class StatementItem: Decodable {
    var date: String?
    var id: String?
    var amount: Int?
    var destination: String?
    var details: String?
    var type: TransactionType?
    var bank: String?
    
    enum CodingKeys: String, CodingKey {
        case id, amount
        case date = "createdAt"
        case destination = "to"
        case details = "description"
        case type = "tType"
        case bank = "bankName"
    }
}
