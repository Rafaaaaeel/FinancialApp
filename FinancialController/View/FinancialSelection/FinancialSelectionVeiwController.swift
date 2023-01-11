import UIKit


class FinancialSelectionVeiwController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CodableViews {
    
    
    
    var total = 5
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout ()
        layout.itemSize = CGSize(
            width: (view.frame.size.width/2.1)-3,
            height: (view.frame.size.width/2.1)-3)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(FinancialSelectionCell.self, forCellWithReuseIdentifier: FinancialSelectionCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

extension FinancialSelectionVeiwController {
    func setupHiearchy() {
        view.addSubview(collectionView)
    }
    
    func setupContraints() {
        let constraints = [
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            collectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: collectionView.trailingAnchor, multiplier: 1),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func additional() {
        setupNavigatioBar()
    }
    
}

extension FinancialSelectionVeiwController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return total
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FinancialSelectionCell.identifier, for: indexPath) as! FinancialSelectionCell
        return cell
    }
    
}

extension FinancialSelectionVeiwController {
    func setupNavigatioBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(addDebit))
        view.backgroundColor = .white
    }
    
    @objc func addDebit() {
        let vc = UINavigationController(rootViewController: RegisterDebitViewController())
        self.navigationController?.present(vc, animated: true)
    }
}
