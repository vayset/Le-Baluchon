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
    
    @IBAction func didTapOnDigitButton(_ sender: UIButton) {
        
        guard let valueToConvertString = valueToConvertLabel.text else { return }
        let concatenatedValueToConvertString = valueToConvertString + String(sender.tag)
        
        guard let valueToConvert = Double(concatenatedValueToConvertString) else { return }
        
        valueToConvertLabel.text = concatenatedValueToConvertString
        
    
        currencyService.getConvertedValue(
            sourceCurrency: sourceCurrency,
            targetCurrency: targetCurrency,
            valueToConvert: valueToConvert,
            completion: assignRateToLabel(result:)
        )
        
    }
    
    func assignRateToLabel(result: Result<String, CurrencyServiceError>) {

        DispatchQueue.main.async {
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.alertManagerController.presentSimpleAlert(from: self, message: error.localizedDescription)
            case .success(let convertedValue):
                self.convertedValueLabel.text = convertedValue
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceCurrency = .euro
        targetCurrency = .usd
    }
}

