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
    
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension HomeView: ViewConfiguration {
    
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func configureViews() {
        self.backgroundColor = .white
    }
    
}
