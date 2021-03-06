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
        label.text = ""
        return label
    }()
    
    private let censorBar: UIView = {
        let view = UIView()
        view.backgroundColor = PhiColors.green.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 20
        
        return stack
    }()
    
    private var shouldCensorAmount: Bool {
        get {
            UserDefaults.standard.bool(forKey: "shouldCensorAmount")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "shouldCensorAmount")
            updateCensorship(shouldCensorAmount: shouldCensorAmount)
        }
    }
    
    func buildViewHierarchy() {
        horizontalStack.addArrangedSubview(balanceTitle)
        horizontalStack.addArrangedSubview(showHideBalance)
        
        verticalStack.addArrangedSubview(horizontalStack)
        verticalStack.addArrangedSubview(balanceLabel)
        
        addSubview(verticalStack)
        addSubview(censorBar)
    }
    
    func setupConstraints() {
        let horizontalStackConstraints = [
            NSLayoutConstraint(item: verticalStack, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: verticalStack, attribute: .left, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .left, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: verticalStack, attribute: .right, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .right, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: verticalStack, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 65),
        ]
        
        let censorBarConstraints = [
            NSLayoutConstraint(item: censorBar, attribute: .centerY, relatedBy: .equal, toItem: balanceLabel, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: censorBar, attribute: .left, relatedBy: .equal, toItem: balanceLabel, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: censorBar, attribute: .width, relatedBy: .equal, toItem: balanceLabel, attribute: .width, multiplier: 1, constant: 40),
            NSLayoutConstraint(item: censorBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 4),
        ]
        
        addConstraints(horizontalStackConstraints)
        addConstraints(censorBarConstraints)
    }
    
    func configureViews() {
        self.backgroundColor = PhiColors.light.color
        self.showHideBalance.addTarget(self, action: #selector(changeAmountCensorship), for: .touchUpInside)
        updateCensorship(shouldCensorAmount: shouldCensorAmount)
    }
    
    func updateCensorship(shouldCensorAmount: Bool) {
        self.balanceLabel.alpha = shouldCensorAmount ? 0 : 1
        self.censorBar.alpha = shouldCensorAmount ? 1 : 0
        self.showHideBalance.setImage(shouldCensorAmount ? BalanceImages.show.image : BalanceImages.hide.image, for: .normal)
    }
    
    @objc func changeAmountCensorship() {
        self.shouldCensorAmount.toggle()
    }
    
    func updateBalance(amount: String) {
        self.balanceLabel.text = amount
    }
    
}
