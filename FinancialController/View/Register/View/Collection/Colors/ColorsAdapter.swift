import UIKit

protocol ColorsAdapterDelegate: AnyObject {
    func didSelectColor(at index: Int)
}


class ColorsAdapter: NSObject {
    weak var delegate: ColorsAdapterDelegate?
    
    override init() {
        super.init()
    }
}

extension ColorsAdapter: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! OptionsCell
        delegate?.didSelectColor(at: indexPath.row)
        cell.selected()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! OptionsCell
//        cell.configureCell(color: colors[indexPath.row])
        cell.deselect()
    }
    
}
