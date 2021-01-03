import Foundation

class UrlSessionDataTaskMock: URLSessionDataTask {
    
    
    init(
        completion: @escaping (Data?, URLResponse?, Error?) -> Void,
        data: Data?,
        response: URLResponse?,
        error: Error?
    ) {
        self.data = data
        self.myResponse = response
        self.myError = error
        self.completion = completion
    }
    
    
    let data: Data?
    let myResponse: URLResponse?
    let myError: Error?
    
    let completion: (Data?, URLResponse?, Error?) -> Void
    
    override func resume() {
        completion(data, myResponse, myError)
    }
    
}
