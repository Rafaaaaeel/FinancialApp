import UIKit

class PaymentCell: UITableViewCell {
    
    static let identifier = "PaymentCell"

    lazy var paymentCellView: PaymentCellView = {
        let view = PaymentCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PaymentCell: CodableViews{
    
    func setupHiearchy() {
        addSubview(paymentCellView)
    }

    func setupContraints() {
        let contraints = [
            paymentCellView.centerYAnchor.constraint(equalTo: centerYAnchor),
            paymentCellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            paymentCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            paymentCellView.heightAnchor.constraint(equalToConstant: 90)
        ]
        NSLayoutConstraint.activate(contraints)
    }
    
    func configureCell(model: Payment, color: UIColor) {
        paymentCellView.name.text = model.name
        paymentCellView.price.text = "R$ \(model.value ?? 0)"
        paymentCellView.priceBackgroundView.backgroundColor = color
    }
    
    func selected() {
        paymentCellView.backgroundColor = .systemGray4
    }
    
    func deselected() {
        paymentCellView.backgroundColor = .systemGray6
    }
}
