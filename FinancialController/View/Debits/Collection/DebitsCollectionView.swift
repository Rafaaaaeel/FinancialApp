import UIKit


class DebitsCollectionView: UICollectionView {
    
    var source: DebitsDataSource
    
    init(source: DebitsDataSource = DebitsDataSource(), width: Double, spacing: CGFloat) {
        self.source = source
        let layout = UICollectionViewFlowLayout ()
        layout.itemSize = CGSize(
            width: width,
            height: width)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        super.init(frame: .zero, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(debits: [Debit]) {
        source.add(debits: debits)
    }
    
}

extension DebitsCollectionView {
    func configure() {
        dataSource = source
//        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        register(FinancialSelectionCell.self, forCellWithReuseIdentifier: FinancialSelectionCell.identifier)
    }
}
