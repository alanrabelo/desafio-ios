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
    func didChangeBalanceVisibility(visible: Bool)
}

class BalanceStatementViewModel: NSObject {
    
    private var balance: Int? {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didLoadBalance(amount: (Double(self.balance ?? 0)/100.0).monetary)
            }
        }
    }
    
    private var page = 0
    private let numberOfItems = 10
    private var noMoreData = false
    
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
        guard noMoreData == false else {
            return
        }
        
        NetworkLayer.shared.perform(route: .statement(numberOfItems, page)) { [weak self] (result: Result<Statement, Error>) in
            switch result {
            case .success(let statement):
                guard let items = statement.items else {
                    return
                }
                
                if items.isEmpty {
                    self?.noMoreData = true
                }
                
                DispatchQueue.main.async {
                    self?.statementItems.append(contentsOf: items)
                    guard let page = self?.page, let numberOfItems = self?.numberOfItems else {
                        return
                    }
                    let range = (page*numberOfItems)..<(page*numberOfItems)+items.count
                    let indexpaths = range.map( {IndexPath(row: $0, section: 0)} )
                    self?.page += 1
                    self?.delegate?.didLoadStatement(atIndexes: indexpaths)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension BalanceStatementViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statementItems.count
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (page * numberOfItems) - 5 {
            loadStatement()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        delegate?.didChangeBalanceVisibility(visible: velocity.y < 0)
    }
}
