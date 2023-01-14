import UIKit

class ColorsDataSource: NSObject {
    
    var colors: [UIColor] = [.red, .purple, .systemPink, .brown, .orange, .cyan, .green, .magenta, .systemYellow]
    
    override init() {
        super.init()
    }
    
    func count() -> Int {
        return colors.count
    }
    
}

extension ColorsDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionsCell.identifier, for: indexPath) as! OptionsCell
        cell.configureCell(color: colors[indexPath.item])
        return cell
    }
    
    
}
