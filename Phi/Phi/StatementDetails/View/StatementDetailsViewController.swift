//
//  StatementDetailsViewController.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import Foundation
import UIKit

class StatementDetailsViewController: UIViewController, Coordinatable {
    
    internal var coordinator: Coordinator
    private var viewModel: StatementViewModel?
    
    init(coordinator: Coordinator, item: StatementViewModel) {
        self.coordinator = coordinator
        self.viewModel = item
        super.init(nibName: nil, bundle: nil)
        title = "Comprovante"
    }
    
    override func loadView() {
        let view = StatementDetailsView()
        view.delegate = viewModel
        self.view = view
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.delegate = self
        viewModel?.loadDetails()
        navigationController?.navigationBar.tintColor = PhiColors.dark.color
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
    }
    
    required init?(coder: NSCoder) {
        coordinator = AppCoordinator(navigationController: UINavigationController())
        super.init(coder: coder)
    }
    
}

extension StatementDetailsViewController: StatementDetailsViewModelDelegate {
    
    func errorLoadingDetails() {
        print("Error in details")
    }
    
    func didFinishLoadingDetails() {
        DispatchQueue.main.async {
            guard let view = self.view as? StatementDetailsView, let details = self.viewModel?.statementDetails else {
                return
            }
            view.setup(viewModel: details)
        }
    }
}

