import UIKit

class RegisterSelectionPresenter {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var image: String?
    var color: Data?
    var name: String?
    
    func saveDebit() {
        guard let image = image, let color = color, let name = name else {
            return
            
        }
        
        let debit = Debit(context: context)
        debit.image = image
        debit.color = color
        debit.payment = nil
        debit.name = name
        debit.total = nil
        try! context.save()
    }
    
}
