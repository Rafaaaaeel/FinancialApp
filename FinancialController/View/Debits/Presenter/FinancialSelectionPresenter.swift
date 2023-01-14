import CoreData

class FinancialSelectionPresenter {
    
    
    var repository: FinancialSelectionRepository
    weak var view: FinancialSelectionVeiwController?
    
    init(repository: FinancialSelectionRepository = FinancialSelectionRepository(), view: FinancialSelectionVeiwController? = nil) {
        self.repository = repository
        self.view = view
    }
    
    
    func fetchDebits() {
        repository.fetchDebits { result in
            switch result {
            case .success(let debits):
                self.successHandler(debits: debits)
            case .failure(_):
                break
            }
        }
    }
    
    private func successHandler(debits: [Debit]) {
        view?.collectionView.add(debits: debits)
        reloadCollectionFromMainThread()
    }
    
    private func reloadCollectionFromMainThread() {
        DispatchQueue.main.async {
            self.view?.collectionView.reloadData()
        }
    }
    
}

