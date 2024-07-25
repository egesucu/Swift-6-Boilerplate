//
//  UserListEditUITests.swift
//  Swift 6 BoilerplateUITests
//
//  Created by Sucu, Ege on 26.07.2024.
//

import Foundation
import XCTest
@testable import Swift_6_Boilerplate

@MainActor
class UserListEditUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testUserEditViewInitialState() throws {
        app.buttons["AddUser"].tap()
        
        let addUserSheet = app.otherElements["UserEditForAdd"]
        XCTAssertTrue(addUserSheet.waitForExistence(timeout: 2))
        
        XCTAssertTrue(addUserSheet.navigationBars["Add User"].exists)
        XCTAssertTrue(addUserSheet.textFields["NameTextField"].exists)
        XCTAssertTrue(addUserSheet.textFields["AgeTextField"].exists)
        XCTAssertTrue(addUserSheet.buttons["SaveUserButton"].exists)
        XCTAssertTrue(addUserSheet.buttons["CancelSaveButton"].exists)
    }
    
    func testUserEditViewCancelButton() throws {
        app.buttons["AddUser"].tap()
        
        let addUserSheet = app.otherElements["UserEditForAdd"]
        XCTAssertTrue(addUserSheet.waitForExistence(timeout: 2))
        
        addUserSheet.buttons["CancelSaveButton"].tap()
        
        XCTAssertTrue(addUserSheet.waitForNonExistence(withTimeout: 5))
    }
    
    func testUserEditViewInvalidInput() throws {
        app.buttons["AddUser"].tap()
        
        let addUserSheet = app.otherElements["UserEditForAdd"]
        XCTAssertTrue(addUserSheet.waitForExistence(timeout: 2))
        
        let nameTextField = addUserSheet.textFields["NameTextField"]
        nameTextField.tap()
        nameTextField.typeText("Test User")
        
        let ageTextField = addUserSheet.textFields["AgeTextField"]
        ageTextField.tap()
        ageTextField.typeText("Invalid Age")
        
        addUserSheet.buttons["SaveUserButton"].tap()
        
        XCTAssertTrue(addUserSheet.exists)
    }
}
