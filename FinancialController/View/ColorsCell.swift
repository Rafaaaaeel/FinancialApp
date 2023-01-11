//
//  ColorsCell.swift
//  FinancialController
//
//  Created by Rafael Oliveira on 10/01/23.
//

import UIKit

class ColorsCell: UICollectionViewCell {
    static var identifier = "ColorsCell"
    
    lazy var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(color: UIColor) {
        colorView.backgroundColor = color
        

    }

    func selected() {
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 4
        layer.borderColor =  .init(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.7)
    }
    
    func deselect() {
        layer.borderWidth = 0
    }
}

extension ColorsCell: CodableViews {
    func setupHiearchy() {
        addSubview(colorView)
    }
    
    func setupContraints() {
        let constraints = [
            colorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            colorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 40),
            colorView.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
}

