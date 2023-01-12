import UIKit

extension UIColor {
    class func color(withData data:Data) -> UIColor {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as! UIColor
       }

       func encode() -> Data {
            return NSKeyedArchiver.archivedData(withRootObject: self)
       }
}
