import UIKit

class PaymentCell: UITableViewCell {
    static let identifier = "PaymentCell"
    
    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension PaymentCell {
    func setupView() {
        setupHiearchy()
        configContraints()
    }
    
    func setupHiearchy() {
        addSubview(name)
        addSubview(price)
    }

    func configContraints() {
        let contraints = [
            name.centerYAnchor.constraint(equalTo: centerYAnchor),
            name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            price.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 16),
            price.centerYAnchor.constraint(equalTo: name.centerYAnchor)
        ]
        NSLayoutConstraint.activate(contraints)
    }
    
    func configureCell(model: Payment) {
        name.text = model.name
        price.text = "R$: \(model.value ?? 0)"
    }
}
