import XCTest
@testable import Le_Baluchon

class NetworkManagerTests: XCTestCase {
    
    var correctData: Data {
        let bundle = Bundle(for: NetworkManagerTests.self)
        let url = bundle.url(forResource: "FakeJson", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    let incorrectData = "erreur".data(using: .utf8)!
    
    func testGivenNetworkManagerWhenResponseIsOkThenNetworkManagerSuccess() {
        
        let responseOK = HTTPURLResponse(url:  URL(string: "www.openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let urlSessionMock = UrlSessionMock(data: correctData, response: responseOK, error: nil)
        
        let networkManager = NetworkManager(session: urlSessionMock)
        
        
        networkManager.fetch(url: URL(string: "www.openclassrooms.com")!) { (result: Result<CodableMock, NetworkManagerError>) in
            switch result {
            case .failure:
                XCTFail()
            case .success:
                XCTAssert(true)
            }
        }
        
    }
    
    func testGivenNetworkManagerWhenResponseIsKoThenNetworkManagerFailure() {
        
        let responseKO = HTTPURLResponse(url:  URL(string: "www.openclassrooms.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let urlSessionMock = UrlSessionMock(data: correctData, response: responseKO, error: nil)
        
        let networkManager = NetworkManager(session: urlSessionMock)
        
        
        networkManager.fetch(url: URL(string: "www.openclassrooms.com")!) { (result: Result<CodableMock, NetworkManagerError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidHttpStatusCode)
                
            case .success:
                XCTFail()
            }
        }
        
    }
    
    func testGivenNetworkManagerWhenDataNilThenWeGetNoData() {
        
        let responseOK = HTTPURLResponse(url:  URL(string: "www.openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let urlSessionMock = UrlSessionMock(data: nil, response: responseOK, error: nil)
        
        let networkManager = NetworkManager(session: urlSessionMock)
        
        
        
        networkManager.fetch(url: URL(string: "www.openclassrooms.com")!) { (result: Result<CodableMock, NetworkManagerError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .noData)
                
            case .success:
                XCTFail()
            }
        }
        
    }
    
    
    func testGivenNetworkManagerWhenURLSessionHasErrorThenUnknownError() {
        
        let responseOK = HTTPURLResponse(url:  URL(string: "www.openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let urlSessionMock = UrlSessionMock(data: correctData, response: responseOK, error: NetworkManagerError.unknownError)
        
        let networkManager = NetworkManager(session: urlSessionMock)
        
        
        networkManager.fetch(url: URL(string: "www.openclassrooms.com")!) { (result: Result<CodableMock, NetworkManagerError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .unknownError)
                
            case .success:
                XCTFail()
            }
        }
        
    }
    
    func testGivenNetworkManagerWhenIncorrectDataThenFailedToDecodeJSON() {
        
        let responseOK = HTTPURLResponse(url:  URL(string: "www.openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let urlSessionMock = UrlSessionMock(data: incorrectData, response: responseOK, error: nil)
        
        let networkManager = NetworkManager(session: urlSessionMock)
        
        
        networkManager.fetch(url: URL(string: "www.openclassrooms.com")!) { (result: Result<CodableMock, NetworkManagerError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .failedToDecodeJSON)
                
            case .success:
                XCTFail()
            }
        }
        
    }
    
}
