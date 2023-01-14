import UIKit

class ImagesCollectionView: UICollectionView {
    var source: ImagesDataSource
    var adapter: ImageAdapter
    
    init(source: ImagesDataSource = ImagesDataSource(),
         adapter: ImageAdapter = ImageAdapter(),
         delegate: ImageAdapterDelegate,
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
    
    func getImage(at index: Int) -> String {
        return source.images[index]
    }
}

extension ImagesCollectionView {
    func configure() {
        dataSource = source
        delegate = adapter
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        register(OptionsCell.self, forCellWithReuseIdentifier: OptionsCell.identifier)
    }
}
