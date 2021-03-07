//
//  LabelGroupView.swift
//  Phi
//
//  Created by Lo on 07/03/21.
//

import UIKit

class LabelGroupView: UIView, ViewConfiguration {
    
    // MARK: - ViewElements
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = PhiColors.dark.color
        return label
    }()
    
    private var detailLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = PhiColors.dark.color

        return label
    }()
    
    private var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initializers
    func setup(title: String, detail: String) {
        self.titleLabel.text = title
        self.detailLabel.text = detail
    }
    
    func buildViewHierarchy() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailLabel)
        addSubview(stackView)
    }
    
    func setupConstraints() {
//        self.stackView.heightAnchor.constraint(equalToConstant: 300).isActive = true

    }
}
