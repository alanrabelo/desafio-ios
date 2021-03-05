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
    private var viewModel: StatementDetailsViewModel?
    
    init(coordinator: Coordinator, item: StatementDetailsViewModel) {
        self.coordinator = coordinator
        self.viewModel = item
        super.init(nibName: nil, bundle: nil)
        self.title = "Comprovante"
    }
    
    override func loadView() {
        self.view = StatementDetailsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.delegate = self
        viewModel?.loadDetails()
    }
    
    override func viewDidLayoutSubviews() {
        (self.view as? StatementDetailsView)?.setupViewConfiguration()
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
    
    func didFinishLoadingDetails(forItem item: StatementDetailsViewModel) {
        DispatchQueue.main.async {
            guard let view = self.view as? StatementDetailsView else {
                return
            }
            view.setup(item: item)
        }
    }
}

