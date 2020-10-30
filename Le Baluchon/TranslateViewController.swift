import UIKit

class TranslateViewController: UIViewController {

    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var translateLabel: UILabel!

    private let networkManager = NetworkManager()


    func assignTranslatedText(translateResponse: Result<TranslateResponse, NetworkManagerError>) {
        
        DispatchQueue.main.async {
            switch translateResponse {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                guard let translatedText = response.data?.translations?.first?.translatedText else { return }
                self.translateLabel.text = translatedText
            }
        }
    }
    

    @IBAction func translateButton() {
        
        guard let url = translateUrlProvider.getTranslateUrl(textToTranslate: translateTextField.text!) else {
            print("Failed to get translate url")
            return
        }
        
        networkManager.fetch(url: url, completion: assignTranslatedText)
    }
    
    private let translateUrlProvider = TranslateUrlProvider()
    
//    func translatorSettings(response: TranslateResponse, translateTextField: UITextField, translateButton: UIButton, translateLabel: UILabel) {
//        translateTextField.text = response.q
//    }
    
    
}


class TranslateUrlProvider {
    
    func getTranslateUrl(textToTranslate: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: "AIzaSyCvWsHARdQkJ2LkskI6fP-xcOQM_Bc-yC0"),
            URLQueryItem(name: "q", value: textToTranslate),
            URLQueryItem(name: "source", value: "en"),
            URLQueryItem(name: "target", value: "fr"),
            URLQueryItem(name: "format", value: "text")
        ]
        
        return urlComponents.url
    }
}
