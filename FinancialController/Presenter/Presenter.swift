import UIKit
import CoreData

class Presenter {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var view: ViewController? = nil 
    var payments: [Payment]? = nil
    
    init() {
        self.fetchRequest()
    }
    
    internal func fetchRequest() {
        let request = Payment.fetchRequest() as NSFetchRequest<Payment>
        self.payments = try! context.fetch(request)
        reloadTableViewFromMainThread()
        
    }
    
    private func reloadTableViewFromMainThread() {
        DispatchQueue.main.async {
            self.view?.tableView.reloadData()
        }
    }
}
