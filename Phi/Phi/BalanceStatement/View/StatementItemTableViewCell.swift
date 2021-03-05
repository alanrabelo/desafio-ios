//
//  StatementItemTableViewCell.swift
//  Phi
//
//  Created by Lo on 05/03/21.
//

import UIKit

class StatementItemTableViewCell: UITableViewCell, ViewConfiguration {
    
    var viewModel: StatementViewModel?
    
    let labelDetails: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = PhiColors.dark.color
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    let labelDestination: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = PhiColors.gray.color
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    let labelAmmount: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = PhiColors.dark.color
        return label
    }()
    
    let labelDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = PhiColors.gray.color
        return label
    }()
    
    let greenDot: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = PhiColors.green.color
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 7
        view.layer.borderColor = PhiColors.light.color.cgColor
        return view
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
        stack.distribution = .equalCentering
        stack.spacing = 20
        
        return stack
    }()
    
    let barDetailsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = 15
        
        return stack
    }()
    
    let background: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let verticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = PhiColors.gray.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pixLabel: UILabel = {
        let label = UILabel()
        label.text = "Pix"
        label.textAlignment = .center
        label.textColor = .systemBackground
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(12)
        label.isHidden = true
        label.backgroundColor = PhiColors.green.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func buildViewHierarchy() {
        
        addSubview(background)
                
        verticalStack.addArrangedSubview(labelDetails)
        verticalStack.addArrangedSubview(labelDestination)
        verticalStack.addArrangedSubview(labelAmmount)
                
        horizontalStack.addArrangedSubview(verticalStack)
        horizontalStack.addArrangedSubview(labelDate)
        background.addSubview(verticalLine)
        verticalLine.addSubview(greenDot)

        background.addSubview(horizontalStack)
        background.addSubview(pixLabel)
    }
    
    func setupConstraints() {
        
        let backgroundCosntraints = [
            NSLayoutConstraint(item: background, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: background, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: background, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: background, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
        ]
        
        let barConstraints = [
            NSLayoutConstraint(item: verticalLine, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 1),
            NSLayoutConstraint(item: verticalLine, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: verticalLine, attribute: .left, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .left, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: verticalLine, attribute: .centerY, relatedBy: .equal, toItem: background, attribute: .centerY, multiplier: 1, constant: 0),
        ]
        
        let horizontalStackConstraints = [
            NSLayoutConstraint(item: horizontalStack, attribute: .height, relatedBy: .equal, toItem: background, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: horizontalStack, attribute: .left, relatedBy: .equal, toItem: verticalLine, attribute: .left, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: horizontalStack, attribute: .right, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .right, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: horizontalStack, attribute: .centerY, relatedBy: .equal, toItem: background, attribute: .centerY, multiplier: 1, constant: 0),
        ]

        let greenDotConstraints = [
            NSLayoutConstraint(item: greenDot, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 14),
            NSLayoutConstraint(item: greenDot, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 14),
            NSLayoutConstraint(item: greenDot, attribute: .centerY, relatedBy: .equal, toItem: verticalLine, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: greenDot, attribute: .centerX, relatedBy: .equal, toItem: verticalLine, attribute: .centerX, multiplier: 1, constant: 0),
        ]
        
        let pixLabelConstraints = [
            NSLayoutConstraint(item: pixLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: pixLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: pixLabel, attribute: .centerX, relatedBy: .equal, toItem: labelDate, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: pixLabel, attribute: .top, relatedBy: .equal, toItem: background, attribute: .top, multiplier: 1, constant: 10),
        ]

        self.addConstraints(backgroundCosntraints)
        self.addConstraints(horizontalStackConstraints)
        self.addConstraints(barConstraints)
        self.addConstraints(greenDotConstraints)
        self.addConstraints(pixLabelConstraints)
    }
    
    func configureViews() {
        guard let isPix = viewModel?.isPix else {
            return
        }
        self.background.backgroundColor = isPix ? PhiColors.light.color : .systemBackground
        self.pixLabel.isHidden = !isPix
    }
    
    func setup() {
        self.labelDetails.text = viewModel?.details
        self.labelDestination.text = viewModel?.destination
        self.labelAmmount.text = viewModel?.value
        self.labelDate.text = viewModel?.date
        self.selectionStyle = .none
    }
}
