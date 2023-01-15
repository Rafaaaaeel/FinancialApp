import UIKit
import CoreData

class PaymentsPresenter {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var view: PaymentsViewController? = nil 
    var payments: [Payment]? = nil
    var debit: Debit
    
    init(debit: Debit) {
        self.debit = debit
        self.fetchRequest()
    }
    
    internal func fetchRequest() {
        self.payments = debit.payment.array(of: Payment.self)
        reloadTableViewFromMainThread()
    }
    
    internal func savePayment(name: String, value: String) {
        let payment = Payment(context: context)
        payment.name = name
        payment.value = NSDecimalNumber(string: value)
        debit.addToPayment(payment)
        saveTotal(payments: debit.payment.array(of: Payment.self))
        try! context.save()
        fetchRequest()
    }
    
    internal func deletePayment(payment: Payment) {
        debit.removeFromPayment(payment)
        saveTotal(payments: debit.payment.array(of: Payment.self))
        try! context.save()
        fetchRequest()
    }
    
    internal func updatePayment(payment: Payment, new name: String, new value: String) {
        payment.name = name
        payment.value = NSDecimalNumber(string: value)
        saveTotal(payments: debit.payment.array(of: Payment.self))
        try! context.save()
        fetchRequest()
    }
    
    private func saveTotal(payments: [Payment]?) {
        guard let payments = payments else { return }
        var total = 0.0
        payments.forEach { payment in
            if let value = payment.value {
                total += value.doubleValue
            }
        }
        self.debit.total = NSDecimalNumber(value: total)
    }
    
    private func reloadTableViewFromMainThread() {
        DispatchQueue.main.async {
            self.view?.tableView.reloadData()
        }
    }
}
