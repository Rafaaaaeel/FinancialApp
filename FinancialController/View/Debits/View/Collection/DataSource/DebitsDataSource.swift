import UIKit


class DebitsDataSource: NSObject {
    
    var debits: [Debit] = []
    
    override init() {
        super.init()
    }
    
    func count() -> Int {
        return debits.count
    }
    
    func add(debits: [Debit]) {
        self.debits = debits
    }
    
    func get(at index: Int) -> Debit {
        return self.debits[index]
    }
    
}

extension DebitsDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FinancialSelectionCell.identifier, for: indexPath) as! FinancialSelectionCell
        cell.configure(with: debits[indexPath.item])
        return cell
    }
}
