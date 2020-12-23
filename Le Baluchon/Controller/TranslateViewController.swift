import UIKit

class TranslateViewController: BaseViewController {

    @IBOutlet weak var targetLanguageLabel: UILabel!
    @IBOutlet weak var sourceLanguageLabel: UILabel!
    
    
    @IBOutlet weak var translatedTextView: UITextView!
    @IBOutlet weak var textToTranslateTextView: UITextView!

    @IBOutlet weak var translateTextUIbutton: UIButton!
    @IBOutlet weak var titleUIView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    private let translateService = TranslateService()
    
    

    func assignTranslatedText(translateResponse: Result<TranslateResponse, NetworkManagerError>) {

        DispatchQueue.main.async {

            self.activityIndicator.stopAnimating()
            
            switch translateResponse {
            case .failure(let error):
                self.alertManagerController.presentSimpleAlert(from: self, message: error.localizedDescription)
            case .success(let response):
                guard let translatedText = response.data?.translations?.first?.translatedText else { return }
                self.translatedTextView.text = translatedText
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customUIView(customUIView: titleUIView)
        customUIView(customUIView: textToTranslateTextView)
        activityIndicator.hidesWhenStopped = true
        
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
        translatedTextView.layer.masksToBounds = true
        translatedTextView.layer.cornerRadius = 5
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

    @IBAction func didTapOnTranslateButton() {
        guard let textToTranslate = textToTranslateTextView.text else { return }
        
        activityIndicator.startAnimating()

        
        translateService.translateText(
            sourceLanguage: sourceLanguage,
            targetLanguage: targetLanguage,
            textToTranslate: textToTranslate,
            completion: assignTranslatedText(translateResponse:)
        )
    
        
    }
}
