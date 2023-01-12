import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    let presenter: Presenter
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PaymentCell.self, forCellReuseIdentifier: PaymentCell.identifier)
        tableView.register(FooterView.self, forHeaderFooterViewReuseIdentifier: "Footer")
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
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(addPerson))
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.payments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentCell.identifier, for: indexPath) as! PaymentCell
        if let payment = presenter.payments {
            cell.configureCell(model: payment[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            if let payment = self.presenter.payments {
                self.presenter.context.delete(payment[indexPath.row])
                
                try! self.presenter.context.save()
                self.presenter.view = self
                self.presenter.fetchRequest()
            }
        }
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        tableView.dequeueReusableHeaderFooterView(withIdentifier: "Footer")
        let view = FooterView()
        var total = 0
        if let payments = presenter.payments {
            payments.forEach { payment in
                total += payment.value?.intValue ?? 0
            }
        }
        view.title.text = "Total: R$ \(total)"
        return view
    }
    
}

extension ViewController {
    @objc
    func addPerson() {
        let alert = UIAlertController(title: "Add payment", message: "What is their name?", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        let submitButton = UIAlertAction(title: "Save", style: .default) { action in
            
            guard let name = alert.textFields![0].text else { return }
            guard let value = alert.textFields![1].text else { return }
            
            let newPayment = Payment(context: self.presenter.context)
            newPayment.name = name
            let finalValue = NSDecimalNumber(string: value)
            newPayment.value = finalValue
            
            print("name: \(name)")
            print("value: \(finalValue)")
            
            try! self.presenter.context.save()
            self.presenter.fetchRequest()
            self.presenter.view = self
        }
        
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
    }
}

