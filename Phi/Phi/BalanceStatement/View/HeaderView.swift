//
//  HeaderView.swift
//  Phi
//
//  Created by Lo on 05/03/21.
//

import UIKit

class HeaderView: UIView, ViewConfiguration {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Suas Movimentações"
        return label
    }()
    
    func setupConstraints() {
        let labelConstraints = [
            NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .left, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
        ]

        self.addConstraints(labelConstraints)
    }
    
    func buildViewHierarchy() {
        addSubview(label)
    }
}
