import UIKit

protocol ImageAdapterDelegate: AnyObject {
    func didSelectImage(at index: Int)
}


class ImageAdapter: NSObject {
    weak var delegate: ImageAdapterDelegate?
    
    override init() {
        super.init()
    }
}

extension ImageAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! OptionsCell
        delegate?.didSelectImage(at: indexPath.row)
        cell.selected()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! OptionsCell
//        cell.configureCell(color: colors[indexPath.row])
        cell.deselect()
    }
}
