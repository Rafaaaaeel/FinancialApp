import UIKit
import CoreData


class FinancialSelectionVeiwController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CodableViews, RegisterDebitViewControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var total: [Debit]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout ()
        layout.itemSize = CGSize(
            width: (view.frame.size.width/2.1)-3,
            height: (view.frame.size.width/2.1)-3)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(FinancialSelectionCell.self, forCellWithReuseIdentifier: FinancialSelectionCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Yees")
    }
    
}

extension FinancialSelectionVeiwController {
    func setupHiearchy() {
        view.addSubview(collectionView)
    }
    
    func setupContraints() {
        let constraints = [
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            collectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: collectionView.trailingAnchor, multiplier: 1),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func additional() {
        setupNavigatioBar()
        fetchPeople()
    }
    
}

extension FinancialSelectionVeiwController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return total?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FinancialSelectionCell.identifier, for: indexPath) as! FinancialSelectionCell
        if let debit = total {
            cell.configure(with: debit[indexPath.item])
        }
        
        return cell
    }
    
}

extension FinancialSelectionVeiwController {
    func setupNavigatioBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(addDebit))
        view.backgroundColor = .white
    }
    
    @objc func addDebit() {
        let viewController = RegisterDebitViewController()
        viewController.delegate = self
        let vc = UINavigationController(rootViewController: viewController)
        self.navigationController?.present(vc, animated: true)
    }
    
    private func fetchPeople() {
        
        let request = Debit.fetchRequest() as NSFetchRequest<Debit>
        
        // Filter by someone
//        let pred = NSPredicate(format: "name CONTAINS %@", "R")
//        let sort = NSSortDescriptor(key: "name", ascending: true )
//        request.sortDescriptors = [sort]
//        request.fetchLimit = 2
//        request.fetchOffset = 4
//        request.predicate = pred
        
        self.total = try! context.fetch(request)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    private func removing() {
        total?.forEach{ debit in
            context.delete(debit)
        }
        try! self.context.save()
        fetchPeople()
    }
}

extension FinancialSelectionVeiwController {
    func didSave() {
        fetchPeople()
        dismiss(animated: true, completion: nil)
    }
}

