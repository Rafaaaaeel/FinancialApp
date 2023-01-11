//
//  FinancialSelectionCell.swift
//  FinancialController
//
//  Created by Rafael Oliveira on 10/01/23.
//

import UIKit

class FinancialSelectionCell: UICollectionViewCell {
    
    static var identifier = "FinancialSelectionCell"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Test"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FinancialSelectionCell: CodableViews {
    func setupHiearchy() {
        addSubview(label)
    }
    
    func setupContraints() {
        let constraints = [
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func additional() {
        layer.cornerRadius = 36
        backgroundColor = .systemPurple
    }
    
    
}
