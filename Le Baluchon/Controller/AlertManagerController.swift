import UIKit


class AlertManagerController {
    func presentSimpleAlert(from viewController: UIViewController, message: String) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(confirmAction)
        
        viewController.present(alertController, animated: true)

        
    }
}


