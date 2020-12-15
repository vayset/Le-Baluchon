import UIKit



class CurrencyViewController: BaseViewController {

    @IBOutlet weak var valueToConvertLabel: UILabel!
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet weak var targetCurrencyImageView: UIImageView!
    @IBOutlet weak var sourceCurrencyImageView: UIImageView!
    
    private let networkManager = NetworkManager()
    private let currencyService = CurrencyService()
    
    private var sourceCurrency: Currency = .euro {
        didSet {
            sourceCurrencyImageView.image = UIImage(named: sourceCurrency.displayIcons)

        }
    }
    
   private var targetCurrency: Currency = .usd {
        didSet{
            targetCurrencyImageView.image = UIImage(named: targetCurrency.displayIcons)

        }
    }
    
    @IBAction func addPoint(_ sender: Any) {
        let point = valueToConvertLabel.text! + String(".")
        valueToConvertLabel.text = point
    }
    
    @IBAction func didTapReverseValueUIButton(_ sender: Any) {
        swap(&sourceCurrency, &targetCurrency)
    }
    
    @IBAction func removeCurrencyLabel(_ sender: Any) {
        valueToConvertLabel.text = ""
        convertedValueLabel.text = ""
    }
    
    @IBAction func digitsButton(_ sender: UIButton) {
        let digit = valueToConvertLabel.text! + String(sender.tag)
        
        valueToConvertLabel.text = digit
        
        guard let url = currencyService.getCurrencyURL() else { return }
        networkManager.fetch(url: url, completion: assignRateToLabel)
        
    }
    
    func assignRateToLabel(currencyResponse: Result<CurrencyResponse, NetworkManagerError>) {

        DispatchQueue.main.async {
            
            switch currencyResponse {
            case .failure(let error):
                print(error.localizedDescription)
                self.alertManagerController.presentSimpleAlert(from: self, message: error.localizedDescription)
            case .success(let response):
                let valueToConvert = Double(self.valueToConvertLabel.text!)!
                print(valueToConvert)
                let convertedValue = valueToConvert * response.rates["\(self.targetCurrency.code)"]!
                print(self.targetCurrency.code)
                print(response.rates["\(self.targetCurrency.code)"]!)
                let valueFormated = String(format: "%.2f", convertedValue)
                self.convertedValueLabel.text = valueFormated.description
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceCurrency = .usd
        targetCurrency = .euro
    }
}

