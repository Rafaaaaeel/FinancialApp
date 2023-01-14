import UIKit
import CoreData


class FinancialSelectionVeiwController: UIViewController, DebitsAdapterDelegate, CodableViews, RegisterDebitViewControllerDelegate {
    
    var presenter: FinancialSelectionPresenter
    lazy var width = (view.frame.size.width/2.1)-3
    
    lazy var collectionView: DebitsCollectionView = {
        let collection = DebitsCollectionView(width: width, spacing: 8, delegate: self)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    init(presenter: FinancialSelectionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDebits()
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
        loadDebits()
    }
    
}

extension FinancialSelectionVeiwController {
    func setupNavigatioBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(addDebit))
        view.backgroundColor = .white
    }
    
    private func loadDebits() {
        presenter.view = self
        presenter.fetchDebits()
    }
    
    @objc func addDebit() {
        let viewController = RegisterDebitViewController()
        viewController.delegate = self
        let vc = UINavigationController(rootViewController: viewController)
        self.navigationController?.present(vc, animated: true)
    }
    
}

extension FinancialSelectionVeiwController {
    func didSave() {
        loadDebits()
        dismiss(animated: true, completion: nil)
    }
    
    func didSelectDebit(at index: Int) {
        let debit = collectionView.get(at: index)
        let viewController = ViewController(presenter: Presenter(debit: debit))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

