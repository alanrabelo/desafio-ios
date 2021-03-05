//
//  ViewController.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import UIKit

class ViewController: UITableViewController, Coordinatable {

    internal var coordinator: Coordinator
    private var viewModel: BalanceStatementViewModel = BalanceStatementViewModel()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.title = "Extrato"
        self.tableView = UITableView(frame: .zero, style: .grouped)
        self.tableView.backgroundColor = .systemBackground
        self.tableView.separatorStyle = .none
    }
    
    override func loadView() {
        self.view = HomeView()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        (self.view as? HomeView)?.setupViewConfiguration()
        self.registerCells()
        self.tableView.delegate = viewModel
        self.tableView.dataSource = viewModel
        viewModel.delegate = self
        viewModel.loadBalance()
        viewModel.loadStatement()
    }
    
    func registerCells() {
        self.tableView.register(StatementItemTableViewCell.self, forCellReuseIdentifier: viewModel.reuseIdentifier)
    }
  
    required init?(coder: NSCoder) {
        coordinator = AppCoordinator(navigationController: UINavigationController())
        super.init(coder: coder)
    }

}

extension ViewController: BalanceStatementViewModelDelegate {
    
    func didSelectElement(item: StatementItem) {
        (coordinator as? AppCoordinator)?.presentDetails(viewModel: StatementDetailsViewModel(statement: item))
    }
    
    func didLoadBalance(amount: String) {
        print(amount)
    }
    
    func didLoadStatement(atIndexes indexes: [IndexPath]) {
        self.tableView.reloadData()
    }
}

