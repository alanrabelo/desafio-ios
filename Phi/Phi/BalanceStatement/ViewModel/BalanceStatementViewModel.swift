//
//  BalanceStatementViewModel.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import PhiNetwork
import Foundation
import UIKit

protocol BalanceStatementViewModelDelegate: class {
    func didLoadBalance(amount: String)
    func didLoadStatement(atIndexes indexes: [IndexPath])
    func didSelectElement(item: StatementItem)
}

class BalanceStatementViewModel: NSObject {
    
    private var balance: Int? {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didLoadBalance(amount: "R$ \(Double(self.balance ?? 0)/100.0)")
            }
            print("Update balance")
        }
    }
    
    let reuseIdentifier: String = "statementCell"
    
    weak var delegate: BalanceStatementViewModelDelegate?
    
    private var statementItems: [StatementItem] = []
    
    func loadBalance() {
        NetworkLayer.shared.perform(route: .balance) { [weak self] (result: Result<Balance, Error>) in
            switch result {
            case .success(let balance):
                self?.balance = balance.amount
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadStatement() {
        NetworkLayer.shared.perform(route: .statement(10, 0)) { [weak self] (result: Result<Statement, Error>) in
            switch result {
            case .success(let statement):
                guard let items = statement.items else {
                    return
                }
                self?.statementItems.append(contentsOf: items)
                DispatchQueue.main.async {
                    self?.delegate?.didLoadStatement(atIndexes: [])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension BalanceStatementViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        statementItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? StatementItemTableViewCell else {
            return UITableViewCell()
        }
        
        let element = statementItems[indexPath.row]
        cell.viewModel = StatementViewModel(statement: element)
        cell.setup()
        cell.setupViewConfiguration()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectElement(item: self.statementItems[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderView()
        view.setupViewConfiguration()
        return view
    }
}
