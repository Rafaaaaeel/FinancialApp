import UIKit


class DebitsCollectionView: UICollectionView {
    
    var source: DebitsDataSource
    var adapter: DebitsAdatpter
    
    init(source: DebitsDataSource = DebitsDataSource(),
         width: Double,
         spacing: CGFloat,
         adapter: DebitsAdatpter = DebitsAdatpter(),
         delegate: DebitsAdapterDelegate) {
        
        self.source = source
        self.adapter = adapter
        self.adapter.delegate = delegate
        
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
    
    func get(at index: Int) -> Debit {
        source.get(at: index)
    }
    
}

extension DebitsCollectionView {
    func configure() {
        dataSource = source
        delegate = adapter
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        register(FinancialSelectionCell.self, forCellWithReuseIdentifier: FinancialSelectionCell.identifier)
    }
}
