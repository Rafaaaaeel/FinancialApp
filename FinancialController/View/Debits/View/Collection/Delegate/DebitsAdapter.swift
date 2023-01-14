import UIKit


protocol DebitsAdapterDelegate: AnyObject {
    func didSelectDebit(at index: Int)
}

class DebitsAdatpter: NSObject {
    
    weak var delegate: DebitsAdapterDelegate?
    
    override init() { }

}

extension DebitsAdatpter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectDebit(at: indexPath.item)
    }
    
}
