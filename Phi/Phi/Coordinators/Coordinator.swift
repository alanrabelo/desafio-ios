//
//  Coordinator.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

protocol Coordinatable: UIViewController {
    var coordinator: Coordinator { get }
}
