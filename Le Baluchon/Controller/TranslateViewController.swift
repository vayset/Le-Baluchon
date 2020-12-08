import UIKit

class TranslateViewController: BaseViewController {

    @IBOutlet weak var targetLanguageLabel: UILabel!
    @IBOutlet weak var sourceLanguageLabel: UILabel!
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var translateLabel: UILabel!
    @IBOutlet weak var translateTextUIbutton: UIButton!
    @IBOutlet weak var titleUIView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let networkManager = NetworkManager()
    private let translateService = TranslateService()

    func assignTranslatedText(translateResponse: Result<TranslateResponse, NetworkManagerError>) {
        
        DispatchQueue.main.async {
            switch translateResponse {
            case .failure(let error):
                self.alertManagerController.presentSimpleAlert(from: self, message: error.localizedDescription)
            case .success(let response):
                guard let translatedText = response.data?.translations?.first?.translatedText else { return }
                self.translateLabel.text = translatedText
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUIView(customUIView: titleUIView)
        
        sourceLanguage = .english
        targetLanguage = .french
    }
    @IBAction func didTapOnLanguageUIButton(_ sender: UIButton) {
        swap(&sourceLanguage, &targetLanguage)
    }
    
    func customUIView(customUIView: UIView) {

        customUIView.layer.cornerRadius = 5
        customUIView.layer.shadowColor = UIColor.black.cgColor
        customUIView.layer.shadowOpacity = 0.2
        customUIView.layer.shadowOffset = .zero
        customUIView.layer.shadowRadius = 10
        translateTextUIbutton.layer.cornerRadius = 5
        translateLabel.layer.masksToBounds = true
        translateLabel.layer.cornerRadius = 5
    }
    
    private var sourceLanguage: Language = .english {
        didSet {
            sourceLanguageLabel.text = sourceLanguage.displayName
        }
    }
    
    
    private var targetLanguage: Language = .french  {
        didSet {
            targetLanguageLabel.text = targetLanguage.displayName
        }
    }

    @IBAction func translateButton() {
        
        guard let url = translateService.getTranslateUrl(
            sourcelanguageCode: sourceLanguage.code,
            targetLanguageCode: targetLanguage.code,
            textToTranslate: translateTextField.text!
        ) else {
            print("Failed to get translate url")
            return
        }
        
        networkManager.fetch(url: url, completion: assignTranslatedText)
    }
    
}
