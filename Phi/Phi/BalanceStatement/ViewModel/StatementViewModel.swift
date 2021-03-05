//
//  StatementViewModel.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import Foundation

class StatementViewModel {
    private let statement: StatementItem
    
    var value: String {
        return (Double(statement.amount ?? 0) / 100.0).monetary
    }
    
    var details: String {
        return statement.description ?? "Sem descrição"
    }
    
    var destination: String {
        statement.to ?? "Sem destinatário"
    }
    
    var date: String {
        statement.createdAt?.short ?? "Sem data informada"
    }
    
    var isPix: Bool {
        return statement.tType?.lowercased().contains("pix") ?? false
    }
    
    init(statement: StatementItem) {
        self.statement = statement
    }
}
