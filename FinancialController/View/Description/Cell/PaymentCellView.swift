import UIKit

class PaymentCellView: UIView {
    
    lazy var priceBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PaymentCellView: CodableViews {
    func setupHiearchy() {
        addSubview(name)
        addSubview(priceBackgroundView)
        priceBackgroundView.addSubview(price)
    }
    
    func setupContraints() {
        let contraints = [
            name.centerYAnchor.constraint(equalTo: centerYAnchor),
            name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            priceBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            priceBackgroundView.centerYAnchor.constraint(equalTo: name.centerYAnchor),
            priceBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            priceBackgroundView.widthAnchor.constraint(equalToConstant: price.frame.width + 80),
            
            price.centerXAnchor.constraint(equalTo: priceBackgroundView.centerXAnchor),
            price.centerYAnchor.constraint(equalTo: priceBackgroundView.centerYAnchor)
            
            
        ]
        NSLayoutConstraint.activate(contraints)
    }
    
    func additional() {
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 15
        backgroundColor = .systemGray6
    }
    
    
}
