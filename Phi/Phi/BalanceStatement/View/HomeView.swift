//
//  HomeView.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import UIKit
import Foundation

class HomeView: UIView {
    
    // MARK: - ViewElements
    
    let balanceView: BalanceView = {
        let view = BalanceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension HomeView: ViewConfiguration {
    
    
    func buildViewHierarchy() {
        self.addSubview(balanceView)
        self.addSubview(tableView)
    }
    
    func setupConstraints() {
        let balanceViewConstraints = [
            NSLayoutConstraint(item: balanceView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: balanceView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: balanceView, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: balanceView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100),
        ]
        
        let tableViewConstraints = [
            NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: balanceView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
        ]
        
        self.addConstraints(balanceViewConstraints)
        self.addConstraints(tableViewConstraints)
    }
    
    func configureViews() {
        balanceView.setupViewConfiguration()
    }
}
