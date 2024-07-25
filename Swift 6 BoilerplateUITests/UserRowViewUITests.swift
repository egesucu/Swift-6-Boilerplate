//
//  UserRowViewUITests.swift
//  Swift 6 BoilerplateUITests
//
//  Created by Sucu, Ege on 26.07.2024.
//

import Foundation
import XCTest
@testable import Swift_6_Boilerplate

@MainActor
class UserRowViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testAddUserFlow() throws {
        try testAddUserFlow(name: "John Doe", age: 30)
    }
    
    func testAddUserFlow(name: String, age: Int) throws {
        app.buttons["AddUser"].tap()
        
        let addUserSheet = app.otherElements["UserEditForAdd"]
        XCTAssertTrue(addUserSheet.waitForExistence(timeout: 10))
        
        let nameTextField = addUserSheet.textFields["NameTextField"]
        XCTAssertTrue(nameTextField.waitForExistence(timeout: 5))
        nameTextField.tap()
        nameTextField.typeText(name)
        
        let ageTextField = addUserSheet.textFields["AgeTextField"]
        XCTAssertTrue(ageTextField.waitForExistence(timeout: 5))
        ageTextField.tap()
        ageTextField.typeText("\(age)")
        
        let saveButton = addUserSheet.buttons["SaveUserButton"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 5))
        saveButton.tap()
        
       
        // Wait for the new user row to appear
        let newUserRow = app.otherElements["UserRow \(name)"]
        XCTAssertTrue(newUserRow.waitForExistence(timeout: 10))
    }
    
    func testUserRowViewDisplaysCorrectInfo() throws {
        try testAddUserFlow()
        let userRow = app.otherElements["UserRow John Doe"]
        XCTAssertTrue(userRow.waitForExistence(timeout: 10))
        
        let nameText = userRow.staticTexts["UserNameText"]
        let ageText = userRow.staticTexts["UserAgeText"]
        
        XCTAssertTrue(nameText.waitForExistence(timeout: 5))
        XCTAssertTrue(ageText.waitForExistence(timeout: 5))
        
        XCTAssertEqual(nameText.label, "John Doe")
        XCTAssertEqual(ageText.label, "Age: 30")
    }
}
