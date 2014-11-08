import Foundation
import UIKit

class FoutBox
{
    var alert: UIAlertController
    
    init(title: String, message: String) {
        self.alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        self.alert.addAction(UIAlertAction(title: "Ga terug", style: UIAlertActionStyle.Default, handler: nil))
    }
    
    /*func getAlert() -> UIAlertController {
        return self.alert
    }*/
}