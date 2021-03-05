//
//  BalanceView.swift
//  Phi
//
//  Created by Lo on 05/03/21.
//

import UIKit

enum BalanceImages: String {
    case show = "eye", hide = "eye.slash"
    
    var image: UIImage? {
        return UIImage(systemName: self.rawValue)
    }
}

class BalanceView: UIView, ViewConfiguration {
    
    private let balanceTitle: UILabel = {
        let label = UILabel()
        label.text = "Seu saldo"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)

        return label
    }()
    
    private let showHideBalance: UIButton = {
        let button = UIButton()
        button.setTitleColor(PhiColors.green.color, for: .normal)
        button.setImage(BalanceImages.show.image, for: .normal)
        button.setImage(BalanceImages.hide.image, for: .highlighted)
        
        return button
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = PhiColors.green.color
        label.font = UIFont.preferredFont(forTextStyle: .title2)

        return label
    }()
    
    let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 7
        
        return stack
    }()
    
    let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 20
        
        return stack
    }()
    
    
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
}
