//
//  BalanceView.swift
//  Phi
//
//  Created by Lo on 05/03/21.
//

import UIKit

enum BalanceImages: String {
    case show = "eye.fill", hide = "eye.slash.fill"
    
    var image: UIImage? {
        return UIImage(systemName: self.rawValue)
    }
}

class BalanceView: UIView, ViewConfiguration {
    
    private let balanceTitle: UILabel = {
        let label = UILabel()
        label.text = "Seu saldo"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let showHideBalance: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = PhiColors.green.color
        button.setImage(BalanceImages.show.image, for: .normal)
        button.setImage(BalanceImages.hide.image, for: .focused)
        
        return button
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = PhiColors.green.color
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(27)
        label.text = "R$ 150,00"
        return label
    }()
    
    let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()
    
    let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 20
        
        return stack
    }()
    
    
    func buildViewHierarchy() {
        horizontalStack.addArrangedSubview(balanceTitle)
        horizontalStack.addArrangedSubview(showHideBalance)
        
        verticalStack.addArrangedSubview(horizontalStack)
        verticalStack.addArrangedSubview(balanceLabel)
        
        addSubview(verticalStack)
    }
    
    func setupConstraints() {
        
        let horizontalStackConstraints = [
            NSLayoutConstraint(item: verticalStack, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: verticalStack, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: verticalStack, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: verticalStack, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 65),
        ]
        
        addConstraints(horizontalStackConstraints)
    }
    
    func configureViews() {
        self.backgroundColor = PhiColors.light.color
    }
    
}
