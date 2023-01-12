//
//  ColorsCell.swift
//  FinancialController
//
//  Created by Rafael Oliveira on 10/01/23.
//

import UIKit

class OptionsCell: UICollectionViewCell {
    static var identifier = "OptionsCell"
    
    lazy var colorView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(color: UIColor? = .clear, image: String? = nil) {
        if let imageName = image {
            let configuration = UIImage.SymbolConfiguration(scale: .small)
            colorView.image = UIImage(systemName: imageName, withConfiguration: configuration)
            colorView.tintColor = .darkGray
            return
        }
        if let color = color {
            colorView.backgroundColor = color
        }
    }

    func selected() {
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 4
        layer.borderColor =  .init(red: 67/255, green: 67/255, blue: 67/255, alpha: 0.7)
    }
    
    func deselect() {
        layer.borderWidth = 0
    }
}

extension OptionsCell: CodableViews {
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

