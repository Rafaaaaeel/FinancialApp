//
//  FinancialSelectionCell.swift
//  FinancialController
//
//  Created by Rafael Oliveira on 10/01/23.
//

import UIKit

class FinancialSelectionCell: UICollectionViewCell {
    
    static var identifier = "FinancialSelectionCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 37)
        label.textColor = .white
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.text = "R$ 1.200,49"
        return label
    }()
    
    lazy var imageSelected: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
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
        addSubview(imageSelected)
        addSubview(titleLabel)
        addSubview(valueLabel)
    }
    
    func setupContraints() {
        let constraints = [
            imageSelected.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            imageSelected.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            valueLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            valueLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func additional() {
        layer.cornerRadius = 36
        backgroundColor = .systemPurple
    }
    
    func configure(with model: Debit) {
        backgroundColor = .color(withData: model.color!)
        titleLabel.text = model.name
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        imageSelected.image = UIImage(systemName: model.image ?? "", withConfiguration: configuration)
    }
    
}
