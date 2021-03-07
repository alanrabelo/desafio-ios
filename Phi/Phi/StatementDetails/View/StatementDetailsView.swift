//
//  StatementDetailsView.swift
//  Phi
//
//  Created by Lo on 04/03/21.
//

import UIKit
import Foundation

enum StatementDetailsFields: String, CaseIterable {
    case details = "Tipo de movimentação"
    case amount = "Valor"
    case destination = "Recebedor"
    case bank = "Instituição Bancária"
    case datetime = "Data/Hora"
    case authCode = "Autenticação"
}

protocol StatementDetailsViewDelegate: class {
    func value(key: StatementDetailsFields) -> String?
}

final class StatementDetailsView: UIView {
    
    // MARK: - ViewElements
    private var stacks: [LabelGroupView] = []
    weak var delegate: StatementDetailsViewDelegate?
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 80
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    // MARK: - Methods
    
    func setup(viewModel: StatementDetailsViewModel) {
        self.backgroundColor = .white
        self.stacks = StatementDetailsFields.allCases.compactMap({
            
            guard let value = delegate?.value(key: $0) else {
                return nil
            }
            
            let view = LabelGroupView()
            view.setup(title: $0.rawValue, detail: value)
            view.setupViewConfiguration()
            return view
        })
        
        setupViewConfiguration()
    }
}

extension StatementDetailsView: ViewConfiguration {
    
    func buildViewHierarchy() {
        
        self.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        
        stacks.forEach {
            mainStackView.addArrangedSubview($0)
            $0.setupViewConfiguration()
        }
    }
    
    func setupConstraints() {
        let constraints = [
            NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        ]
        
        addConstraints(constraints)
        
        let stackConstraints = [
            NSLayoutConstraint(item: mainStackView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: mainStackView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: mainStackView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: mainStackView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: mainStackView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: -40)
        ]
        
        addConstraints(constraints)
        addConstraints(stackConstraints)
    }
    
    func configureViews() {
        backgroundColor = .systemBackground
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
    }
}
