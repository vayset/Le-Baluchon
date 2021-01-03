

import UIKit

class BaseViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseKeyboardGestureRecognizer()
    }
    
    let alertManagerController = AlertManagerController()
    
    private func addCloseKeyboardGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
