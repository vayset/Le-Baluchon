import UIKit

class CurrencyViewController: BaseViewController {

    @IBOutlet weak var valueToConvertLabel: UILabel!
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet weak var euroValueImageView: UIImageView!
    @IBOutlet weak var usdValueImageView: UIImageView!
    
    @IBAction func didTapOnConvertButton() {
        let urlString = "http://data.fixer.io/api/latest?access_key=7dc786b7cef348978bc4d5664e536441"
        let url = URL(string: urlString)!
        networkManager.fetch(url: url, completion: assignRateToLabel)
        
        print("hello")
        
        
        
    }
    
    @IBAction func addPoint(_ sender: Any) {
        let point = valueToConvertLabel.text! + String(".")
        valueToConvertLabel.text = point
    }
    
    @IBAction func removeCurrencyLabel(_ sender: Any) {
        valueToConvertLabel.text?.removeAll()
        convertedValueLabel.text?.removeAll()
    }
    
    @IBAction func digitsButton(_ sender: UIButton) {
        let digit = valueToConvertLabel.text! + String(sender.tag)
        
        valueToConvertLabel.text = digit
        
        
        //        valueToConvertTextField.text = digitArray.f
        let urlString = "http://data.fixer.io/api/latest?access_key=7dc786b7cef348978bc4d5664e536441"
        let url = URL(string: urlString)!
        networkManager.fetch(url: url, completion: assignRateToLabel)
        
    }
    
    func assignRateToLabel(currencyResponse: Result<CurrencyResponse, NetworkManagerError>) {
        print("Saddam")
        DispatchQueue.main.async {
            
            switch currencyResponse {
            case .failure(let error):
                print(error.localizedDescription)
                self.alertManagerController.presentSimpleAlert(from: self, message: error.localizedDescription)
                
            case .success(let response):
                let valueToConvert = Double(self.valueToConvertLabel.text!)!
                let convertedValue = valueToConvert * response.rates["USD"]!
                let valueFormated = String(format: "%.2f", convertedValue)
                self.convertedValueLabel.text = valueFormated.description
            }
            
        }
        
    }
    

    
    private let networkManager = NetworkManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        euroValueImageView.image = UIImage(named: "euro")
        usdValueImageView.image = UIImage(named: "usd")
    }
}

