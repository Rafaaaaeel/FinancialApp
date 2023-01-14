import UIKit

extension UIColor {
    class func color(withData data:Data) -> UIColor {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as! UIColor
       }

       func encode() -> Data {
            return NSKeyedArchiver.archivedData(withRootObject: self)
       }
}

extension Optional where Wrapped == NSSet {
    func array<T: Hashable>(of: T.Type) -> [T] {
        if let set = self as? Set<T> {
            return Array(set)
        }
        return [T]()
    }
}
