import CoreData
import UIKit


class FinancialSelectionRepository {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchDebits(completion: @escaping (Result<[Debit], Error>) -> ()){
        
        let request = Debit.fetchRequest() as NSFetchRequest<Debit>
        
        // Filter by someone
//        let pred = NSPredicate(format: "name CONTAINS %@", "R")
//        let sort = NSSortDescriptor(key: "name", ascending: true )
//        request.sortDescriptors = [sort]
//        request.fetchLimit = 2
//        request.fetchOffset = 4
//        request.predicate = pred
        do {
            guard let debits = try? context.fetch(request) else { return }
            completion(.success(debits))
        } 
    }
    

    func deleteAll(debits: [Debit]) {
        debits.forEach{ debit in
            context.delete(debit)
        }
        do {
            try? self.context.save()
        }
        
    }
    
}

