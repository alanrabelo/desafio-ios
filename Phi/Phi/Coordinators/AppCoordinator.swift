//
//  AppCoordinator.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentDetails(viewModel: StatementDetailsViewModel) {
        let detailsViewController = StatementDetailsViewController(coordinator: self, item: viewModel)
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
