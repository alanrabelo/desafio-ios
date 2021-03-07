//
//  StatementDetails.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import Foundation
struct StatementDetails: Decodable {
    var authentication: String?
    var date: String?
    var id: String?
    var amount: Int?
    var destination: String?
    var details: String?
    var type: TransactionType?
    var bank: String?
    
    enum CodingKeys: String, CodingKey {
        case id, amount, authentication
        case date = "createdAt"
        case destination = "to"
        case details = "description"
        case type = "tType"
        case bank = "bankName"
    }
}
