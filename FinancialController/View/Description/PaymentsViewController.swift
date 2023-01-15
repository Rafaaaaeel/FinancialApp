import UIKit

class PaymentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    let presenter: PaymentsPresenter
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(PaymentCell.self, forCellReuseIdentifier: PaymentCell.identifier)
        return tableView
    }()
    
    init(presenter: PaymentsPresenter) {
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
        navigationController?.navigationBar.tintColor = UIColor.color(withData: presenter.debit.color!)
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(addDebit))
    }
}

extension PaymentsViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.payments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentCell.identifier, for: indexPath) as! PaymentCell
        if let payment = self.presenter.payments {
            if let color = self.presenter.debit.color {
                if payment.count > 0 {
                    cell.configureCell(model: payment[indexPath.row], color: UIColor.color(withData: color))
                }
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            if let payment = self.presenter.payments {
                let payment = payment[indexPath.row]
                self.presenter.view = self
                self.presenter.deletePayment(payment: payment)
            }
            
        }
        return UISwipeActionsConfiguration(actions: [action])

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PaymentCell
        cell.selectionStyle = .none
        cell.selected()
        if let payments = presenter.payments {
            let payment = payments[indexPath.row]
            self.presenter.view = self
            showEditModal(payment: payment)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PaymentCell
        cell.selectionStyle = .none
        cell.deselected()
    }

}

extension PaymentsViewController {
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
    
    private func showEditModal(payment: Payment) {
        let alert = UIAlertController(title: "Add payment", message: "What is their name?", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        
        let texFieldName = alert.textFields![0]
        let textFieldValue = alert.textFields![1]
        
        texFieldName.text = payment.name
        if let value = payment.value {
            textFieldValue.text = "\(value)"
        }
        
        let submitButton = UIAlertAction(title: "Save", style: .default) { action in
            guard let name = texFieldName.text else { return }
            guard let value = textFieldValue.text else { return }
            self.presenter.updatePayment(payment: payment, new: name, new: value)
        }
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func savePayment(name: String, value: String) {
        presenter.savePayment(name: name, value: value)
        presenter.view = self
    }
}

