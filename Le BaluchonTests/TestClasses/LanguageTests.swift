//
//  LanguageTests.swift
//  Le BaluchonTests
//
//  Created by Saddam Satouyev on 08/01/2021.
//
@testable import Le_Baluchon
import XCTest

class LanguageTests: XCTestCase {
    
    func testGivenEnglishLanguageWhenGettingDisplayNameThenIsValid() {
        let englishLanguage = Language.english
        
        XCTAssertEqual(englishLanguage.displayName, "English")
        
    }
    
    func testGivenFrenchLanguageWhenGettingDisplayNameThenIsValid() {
        let frenchLanguage = Language.french
        
        XCTAssertEqual(frenchLanguage.displayName, "French")
        
    }
    
}
