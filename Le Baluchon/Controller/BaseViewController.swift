

import UIKit

class BaseViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseKeyboardGestureRecognizer()
    }
    
    let alertManagerController = AlertManagerController()
    
     func setupLoadingIndicatorViews(activityIndicator: UIActivityIndicatorView) {
        if #available(iOS 13.0, *) {
             activityIndicator.style = .large
         } else {
             activityIndicator.style = .whiteLarge
         }
        
        
        activityIndicator.hidesWhenStopped = true
    }
    
    private func addCloseKeyboardGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
