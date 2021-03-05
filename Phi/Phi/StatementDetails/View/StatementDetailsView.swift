//
//  StatementDetailsView.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import UIKit
import Foundation

class StatementDetailsView: UIView {
    
    // MARK: - ViewElements
    
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(item: StatementDetailsViewModel) {
        
    }
}

extension StatementDetailsView: ViewConfiguration {
    
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func configureViews() {
        self.backgroundColor = .white
    }
    
}
