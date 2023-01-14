import UIKit
import CoreData

class Presenter {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var view: ViewController? = nil 
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
        
        if let total = debit.total {
            debit.total = saveTotal(value: value, total: total)
        } else {
            debit.total = NSDecimalNumber(string: value)
        }
        
        debit.addToPayment(payment)
        try! context.save()
    }
    
    private func saveTotal(value: String, total: NSDecimalNumber) -> NSDecimalNumber {
        let total = NSDecimalNumber(string: value).intValue + total.intValue
        return NSDecimalNumber(string: "\(total)")
    }
    
    private func reloadTableViewFromMainThread() {
        DispatchQueue.main.async {
            self.view?.tableView.reloadData()
        }
    }
}
