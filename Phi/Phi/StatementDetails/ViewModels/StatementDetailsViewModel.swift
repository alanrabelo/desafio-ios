//
//  StatementDetailsViewModel.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import Foundation
import PhiNetwork

class StatementDetailsViewModel {
        
    func value(field: StatementDetailsFields) -> String? {
        switch field {
        
        case .details:
            return self.details
        case .amount:
            return self.amount
        case .destination:
            return self.destination
        case .bank:
            return bankName
        case .datetime:
            return self.date
        case .authCode:
            return self.authNumber
        }
    }
    
    private var statementDetails: StatementDetails?
    
    var details: String? {
        statementDetails?.details?.capitalized
    }
    
    var amount: String {
        (Double(statementDetails?.amount ?? 0)/100).monetary
    }
    
    var destination: String? {
        statementDetails?.destination
    }
    
    var bankName: String? {
        statementDetails?.bank
    }
    
    var date: String? {
        statementDetails?.date?.long
    }
        
    var authNumber: String? {
        statementDetails?.authentication
    }
    
    init(statementDetails: StatementDetails) {
        self.statementDetails = statementDetails
    }
}
