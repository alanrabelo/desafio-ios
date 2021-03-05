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

class StatementItem: Decodable {
    var createdAt: String?
    var id: String?
    var amount: Int?
    var to: String?
    var description: String?
    var tType: String?
}
