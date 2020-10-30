//
//  Le_BaluchonTests.swift
//  Le BaluchonTests
//
//  Created by Saddam Satouyev on 06/10/2020.
//

import XCTest
@testable import Le_Baluchon

class Le_BaluchonTests: XCTestCase {


    func testExample() throws {
        let urlString = "https://translation.googleapis.com/language/translate/v2?key=AIzaSyCvWsHARdQkJ2LkskI6fP-xcOQM_Bc-yC0&q=moi&source=en&target=fr&format=text"
        
        let translateUrlProvider = TranslateUrlProvider()
        let urlCreated = translateUrlProvider.getTranslateUrl(textToTranslate: "moi")!
        XCTAssertEqual(urlString, urlCreated.absoluteString)

    }


}
