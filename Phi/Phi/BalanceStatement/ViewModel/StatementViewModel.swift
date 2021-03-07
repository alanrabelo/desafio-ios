//
//  StatementViewModel.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import Foundation
import PhiNetwork

protocol StatementDetailsViewModelDelegate: class {
    func errorLoadingDetails()
    func didFinishLoadingDetails()
}

class StatementViewModel {
    private let statement: StatementItem
    var statementDetails: StatementDetailsViewModel?
    
    weak var delegate: StatementDetailsViewModelDelegate?

    var value: String {
        return (Double(statement.amount ?? 0) / 100.0).monetary
    }
    
    var details: String {
        return statement.details ?? "Sem descrição"
    }
    
    var destination: String {
        statement.destination ?? "Sem destinatário"
    }
    
    var date: String {
        statement.date?.short ?? "Sem data informada"
    }
    
    var isPix: Bool {
        return statement.type?.rawValue.lowercased().contains("pix") ?? false
    }
    
    init(statement: StatementItem) {
        self.statement = statement
    }
    
    func loadDetails() {
        
        guard let id = self.statement.id else {
            delegate?.errorLoadingDetails()
            return
        }
        
        NetworkLayer.shared.perform(route: .details(id)) { [weak self] (result: Result<StatementDetails, Error>) in
            switch result {
            case .success(let statementDetails):
                
                self?.statementDetails = StatementDetailsViewModel(statementDetails: statementDetails)
                self?.delegate?.didFinishLoadingDetails()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension StatementViewModel: StatementDetailsViewDelegate {
    func value(key: StatementDetailsFields) -> String? {
        statementDetails?.value(field: key)
    }
}
