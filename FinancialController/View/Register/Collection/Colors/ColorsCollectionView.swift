import UIKit

class ColorsCollectionView: UICollectionView {
    var source: ColorsDataSource
    var adapter: ColorsAdapter
    
    init(source: ColorsDataSource = ColorsDataSource(),
         adapter: ColorsAdapter = ColorsAdapter(),
         delegate: ColorsAdapterDelegate,
         width: Double) {
        self.source = source
        self.adapter = adapter
        self.adapter.delegate = delegate
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: width,
            height: width)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        super.init(frame: .zero, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    (view.frame.size.width/6)-6
}

extension ColorsCollectionView {
    func configure() {
        dataSource = source
        delegate = adapter
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        register(OptionsCell.self, forCellWithReuseIdentifier: OptionsCell.identifier)
    }
}
