import UIKit


final class CurrencyViewController: BaseViewController {
    
    // MARK: - IBOutlets / IBActions
    
    @IBOutlet private weak var valueToConvertLabel: UILabel!
    @IBOutlet private weak var convertedValueLabel: UILabel!
    @IBOutlet private weak var targetCurrencyImageView: UIImageView!
    @IBOutlet private weak var sourceCurrencyImageView: UIImageView!
    
    @IBAction private func addPoint(_ sender: Any) {
        guard
            let valueToConvertLabelText = valueToConvertLabel.text,
            !valueToConvertLabelText.contains("."),
            !valueToConvertLabelText.isEmpty
        else { return }
        
        valueToConvertLabel.text = (valueToConvertLabel.text ?? "0") + "."
        
    }
    
    @IBAction private func didTapReverseValueUIButton(_ sender: Any) {
        swap(&sourceCurrency, &targetCurrency)
    }
    
    @IBAction private func removeCurrencyLabel(_ sender: Any) {
        valueToConvertLabel.text = ""
        convertedValueLabel.text = ""
    }
    
    @IBAction private func didTapOnDigitButton(_ sender: UIButton) {
        
        guard let valueToConvertString = valueToConvertLabel.text else { return }
        
        if valueToConvertString == "0" {
            valueToConvertLabel.text?.removeLast()
        }
        
        guard let nezValueToConvertString = valueToConvertLabel.text else { return }
        let concatenatedValueToConvertString = nezValueToConvertString + String(sender.tag)
        
        guard let valueToConvert = Double(concatenatedValueToConvertString) else { return }
        
        valueToConvertLabel.text = concatenatedValueToConvertString
        
        currencyService.getConvertedValue(
            sourceCurrency: sourceCurrency,
            targetCurrency: targetCurrency,
            valueToConvert: valueToConvert,
            completion: assignRateToLabel(result:)
        )
        
    }
    
    // MARK: - Internal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceCurrency = .euro
        targetCurrency = .usd
    }
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
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
    
    // MARK: - Methods - Private
    
    private func assignRateToLabel(result: Result<String, CurrencyServiceError>) {
        
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
    
}
