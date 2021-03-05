//
//  ViewController.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import UIKit

class ViewController: UIViewController, Coordinatable {

    internal var coordinator: Coordinator
    private var viewModel: BalanceStatementViewModel = BalanceStatementViewModel()
    private var homeView = HomeView()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.title = "Extrato"
    }
    
    override func loadView() {
        self.view = homeView
        homeView.configureViews()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = PhiColors.light.color
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        (self.view as? HomeView)?.setupViewConfiguration()
        self.registerCells()
        homeView.tableView.delegate = viewModel
        homeView.tableView.dataSource = viewModel
        viewModel.delegate = self
        viewModel.loadBalance()
        viewModel.loadStatement()
    }
    
    func registerCells() {
        homeView.tableView.register(StatementItemTableViewCell.self, forCellReuseIdentifier: viewModel.reuseIdentifier)
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
        homeView.tableView.reloadData()
    }
}

