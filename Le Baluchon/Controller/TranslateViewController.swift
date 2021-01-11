import UIKit

final class TranslateViewController: BaseViewController {
    
    // MARK: - IBOutlets / IBActions
    
    @IBOutlet weak private var titleUIView: UIView!

    @IBOutlet weak private var targetLanguageLabel: UILabel!
    @IBOutlet weak private var sourceLanguageLabel: UILabel!
    
    @IBOutlet weak private var translatedTextView: UITextView!
    @IBOutlet weak private var textToTranslateTextView: UITextView!
    
    @IBOutlet weak private var translateTextUIbutton: UIButton!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    @IBAction private func didTapOnTranslateButton() {
        guard let textToTranslate = textToTranslateTextView.text else { return }
        
        activityIndicator.startAnimating()
        
        translateService.translateText(
            sourceLanguage: sourceLanguage,
            targetLanguage: targetLanguage,
            textToTranslate: textToTranslate,
            completion: assignTranslatedText(translateResponse:)
        )
        
    }
    
    @IBAction private func didTapOnLanguageUIButton(_ sender: UIButton) {
        swap(&sourceLanguage, &targetLanguage)
    }
    
    // MARK: - Internal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyRoundCornerViewStyle(view: titleUIView)
        applyRoundCornerViewStyle(view: textToTranslateTextView)
        applyRoundCornerViewStyle(view: translatedTextView)
        applyRoundCornerViewStyle(view: translateTextUIbutton)
        setupLoadingIndicatorViews(activityIndicator: activityIndicator)

        sourceLanguage = .english
        targetLanguage = .french
    }
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private let translateService = TranslateService()
    
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
    
    // MARK: - Methods - Private
    
    private func assignTranslatedText(translateResponse: Result<TranslateResponse, NetworkManagerError>) {
        
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
    
    private func applyRoundCornerViewStyle(view: UIView) {
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        view.layer.masksToBounds = true
    }
}
