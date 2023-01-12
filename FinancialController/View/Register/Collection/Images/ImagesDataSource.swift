import UIKit

class ImagesDataSource: NSObject {
    
    var images: [String] = ["eurosign.circle.fill", "cart.fill", "creditcard.fill", "dollarsign.circle.fill", "list.clipboard.fill"]
    
    override init() {
        super.init()
    }
    
    func count() -> Int {
        return images.count
    }
    
}

extension ImagesDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionsCell.identifier, for: indexPath) as! OptionsCell
        cell.configureCell(image: images[indexPath.item])
        return cell
    }
    
    
}
