import UIKit

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var valueToConvertTextField: UITextField!
    
    @IBOutlet weak var convertedValueLabel: UILabel!
    
    
    @IBAction func didTapOnConvertButton() {
        
        let urlString = "http://data.fixer.io/api/latest?access_key=7dc786b7cef348978bc4d5664e536441"
        let url = URL(string: urlString)!
        networkManager.fetch(url: url, completion: assignRateToLabel)
        
        print("hello")
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func assignRateToLabel(currencyResponse: Result<CurrencyResponse, NetworkManagerError>) {
        print("Saddam")
        DispatchQueue.main.async {
            
            switch currencyResponse {
            case .failure(let error):
                print(error.localizedDescription)
                self.presentAlert(error: error)
                
            case .success(let response):
                let valueToConvert =  Double(self.valueToConvertTextField.text!)!
                let convertedValue = valueToConvert * response.rates["CHF"]!
                let valueFormated = String(format: "Value: %.1f", convertedValue)
                self.convertedValueLabel.text = valueFormated.description
            }
           
        }
       
    }
    
    private func presentAlert(error: NetworkManagerError) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
    }
    
    private let networkManager = NetworkManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}



enum NetworkManagerError: Error {
    case noData
    case failedToDecodeJSON
    case unknownError
    case invalidHttpStatusCode
    case couldNotCreateUrl
}


class NetworkManager {
    
    
//    func getRate(completion: @escaping (Double) -> Void)  {
//        DispatchQueue.global(qos: .background).async {
//            completion(1.08)
//        }
//    }
    
    
    func fetch<T : Codable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void)  {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.unknownError))
                return
            }
            
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                completion(.failure(.invalidHttpStatusCode))
                return
            }
            
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            
            
            guard let decoddedData = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.failedToDecodeJSON))
                return
            }
            
            
            completion(.success(decoddedData))
            return
            
            
        }
        
        task.resume()
        
    }
    
}

