import UIKit

enum Value {
    case euro
    case usd
    
    var code: String {
        switch self {
        case .euro: return "EUR"
        case .usd: return "USD"
        }
        
    }
    
    
    var displayIcons: String {
        switch self {
        case .euro: return "euro"
        case .usd: return "usd"
        }
    }
    
}

class CurrencyViewController: BaseViewController {

    @IBOutlet weak var valueToConvertLabel: UILabel!
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet weak var euroValueImageView: UIImageView!
    @IBOutlet weak var usdValueImageView: UIImageView!
    
    private var valueToConvertOne: Value = .euro {
        didSet {
            usdValueImageView.image = UIImage(named: valueToConvertOne.displayIcons)

        }
    }
    
   private var convertedValueOne: Value = .usd {
        didSet{
            euroValueImageView.image = UIImage(named: convertedValueOne.displayIcons)

        }
    }

    
    @IBAction func addPoint(_ sender: Any) {
        let point = valueToConvertLabel.text! + String(".")
        valueToConvertLabel.text = point
    }
    
    @IBAction func didTapReverseValueUIButton(_ sender: Any) {
        swap(&valueToConvertOne, &convertedValueOne)
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
                print(valueToConvert)
                let convertedValue = valueToConvert * response.rates["\(self.convertedValueOne.code)"]!
                print(self.convertedValueOne.code)
                print(response.rates["\(self.convertedValueOne.code)"]!)
                let valueFormated = String(format: "%.2f", convertedValue)
                self.convertedValueLabel.text = valueFormated.description
            }
            
        }
        
    }
    
    private let networkManager = NetworkManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        valueToConvertOne = .usd
        convertedValueOne = .euro
    }
}

