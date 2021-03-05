//
//  StatementDetailsViewModel.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import Foundation
import PhiNetwork

protocol StatementDetailsViewModelDelegate {
    func errorLoadingDetails()
    func didFinishLoadingDetails(forItem item: StatementDetailsViewModel)
}

class StatementDetailsViewModel {
    
    private var statement: StatementItem {
        didSet {
            loadDetails()
        }
    }
    
    private var statementDetails: StatementDetails?
    var delegate: StatementDetailsViewModelDelegate?
    
    var type: String {
        statementDetails?.tType ?? "Nenhum tipo encontrado"
    }
    
    var amount: String {
        "R$ \(Double(statementDetails?.amount ?? 0)/100)"
    }
    
    var destination: String {
        statementDetails?.to ?? "Destino não informado"
    }
    
    var date: String {
        statementDetails?.createdAt ?? "Sem data"
    }
        
    var authNumber: String {
        statementDetails?.authentication ?? "Transação sem autenticação"
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
                self?.statementDetails = statementDetails
                self?.delegate?.didFinishLoadingDetails(forItem: StatementDetailsViewModel(statement: statementDetails))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
