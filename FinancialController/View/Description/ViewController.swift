import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    let presenter: Presenter
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PaymentCell.self, forCellReuseIdentifier: PaymentCell.identifier)
        return tableView
    }()
    
    init(presenter: Presenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        setupHiearchy()
        setupNavigatioBar()
    }
    
    func setupHiearchy() {
        view.addSubview(tableView)
    }
    
    func setupNavigatioBar() {
        title = presenter.debit.name
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(addDebit))
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.payments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentCell.identifier, for: indexPath) as! PaymentCell
        if let payment = self.presenter.payments {
            if payment.count > 0 {
                cell.configureCell(model: payment[indexPath.row])
            }
        }
        return cell
    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
//            if let payment = self.presenter.payments {
//                let result = payment[indexPath.row].value?.intValue ?? 0 - (self.debit.total?.intValue ?? 0) == 0 ? nil : payment[indexPath.row].value?.intValue ?? 0 - (self.debit.total?.intValue ?? 0)
//
//                self.debit.total = NSDecimalNumber(integerLiteral: result ?? 0)
//                self.presenter.context.delete(payment[indexPath.row])
//
//                try! self.presenter.context.save()
//                self.presenter.view = self
//                self.presenter.fetchRequest()
//            }
//        }
//        return UISwipeActionsConfiguration(actions: [action])
//
//    }
//
}

extension ViewController {
    @objc func addDebit() {
        showModal()
    }
    
    private func showModal() {
        let alert = UIAlertController(title: "Add payment", message: "What is their name?", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        let submitButton = UIAlertAction(title: "Save", style: .default) { action in
            guard let name = alert.textFields![0].text else { return }
            guard let value = alert.textFields![1].text else { return }
            self.savePayment(name: name, value: value)
        }

        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func savePayment(name: String, value: String) {
        presenter.savePayment(name: name, value: value)
        presenter.view = self
        presenter.fetchRequest()
    }
}

