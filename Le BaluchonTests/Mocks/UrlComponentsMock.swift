import Foundation
@testable import Le_Baluchon


struct UrlComponentsMock: UrlComponentsProtocol {
    var scheme: String? = ""
    
    var host: String? = ""
    
    var path: String = ""
    
    var queryItems: [URLQueryItem]? = []
    
    var url: URL? = nil
    
    
}
