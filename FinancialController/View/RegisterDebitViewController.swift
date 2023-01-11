//
//  RegisterDebitViewController.swift
//  FinancialController
//
//  Created by Rafael Oliveira on 10/01/23.
//

import UIKit

class RegisterDebitViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var colors: [UIColor] = [.red, .purple, .systemPink, .brown, .orange, .cyan, .green, .magenta, .systemYellow]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout ()
        layout.itemSize = CGSize(
            width: (view.frame.size.width/6)-6,
            height: (view.frame.size.width/6)-6)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(ColorsCell.self, forCellWithReuseIdentifier: ColorsCell.identifier)
        return collection
    }()
    
    
    lazy var colorSelectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select color"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var imageSelectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select image"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    

}

extension RegisterDebitViewController: CodableViews {
    func setupHiearchy() {
        view.addSubview(colorSelectionLabel)
        view.addSubview(collectionView)
        view.addSubview(imageSelectionLabel)
    }
    
    func setupContraints() {
        let constraints = [
            colorSelectionLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4),
            colorSelectionLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            collectionView.topAnchor.constraint(equalTo: colorSelectionLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: colorSelectionLabel.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: imageSelectionLabel.topAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: collectionView.trailingAnchor, multiplier: 2),
            
            imageSelectionLabel.topAnchor.constraint(equalTo: view.centerYAnchor),
            imageSelectionLabel.leadingAnchor.constraint(equalTo: colorSelectionLabel.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func additional() {
        view.backgroundColor = .lightGray
        setupNavigatioBar()
    }
    
    func setupNavigatioBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(saveDebit))
        title = "Debit"
        
    }
    
    
    @objc func saveDebit() {
        print("Saved")
        self.navigationController?.popViewController(animated: true)
    }
}


extension RegisterDebitViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorsCell.identifier, for: indexPath) as! ColorsCell
        cell.configureCell(color: colors[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ColorsCell
        cell.selected()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ColorsCell
//        cell.configureCell(color: colors[indexPath.row])
        cell.deselect()
    }
    
}
