//
//  UserListViewUITests.swift
//  Swift 6 BoilerplateUITests
//
//  Created by Sucu, Ege on 25.07.2024.
//

import XCTest
@testable import Swift_6_Boilerplate

@MainActor
class UserListViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
        
    func testInitialViewState() throws {
        XCTAssertTrue(app.navigationBars["Users"].exists)
        XCTAssertTrue(app.buttons["AddUser"].exists)
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
    
    func testEditUserFlow() throws {
        try testAddUserFlow()
        
        let userRow = app.otherElements["UserRow John Doe"]
        userRow.tap()
        
        let editUserSheet = app.otherElements["UserEdit John Doe"]
        let nameTextField = editUserSheet.textFields["NameTextField"]
        nameTextField.tap()
        nameTextField.typeText(" Jr.")
        
        let ageTextField = editUserSheet.textFields["AgeTextField"]
        ageTextField.tap()
        ageTextField.typeText(XCUIKeyboardKey.delete.rawValue)
        ageTextField.typeText("1")
        
        let saveButton = editUserSheet.buttons["SaveUserButton"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 5))
        saveButton.tap()
        print("Tapped save button")
        
        // Wait for the updated user row to appear
        let updatedUserRow = app.otherElements["UserRow John Doe Jr."]
        // Verify the contents of the updated row
        let nameLabel = updatedUserRow.staticTexts["UserNameText"]
        let ageLabel = updatedUserRow.staticTexts["UserAgeText"]
        
        XCTAssertEqual(nameLabel.label, "John Doe Jr.")
        XCTAssertEqual(ageLabel.label, "Age: 31")
    }
    
    func testDeleteUser() throws {
        try testAddUserFlow(name: "Jane Smith", age: 30)
        let userRow = app.otherElements["UserRow Jane Smith"]
        XCTAssertTrue(userRow.waitForExistence(timeout: 10))
        
        userRow.swipeLeft()
        
        let deleteButton = app.buttons["Delete"]
        XCTAssertTrue(deleteButton.waitForExistence(timeout: 5))
        deleteButton.tap()
        
        // Wait for the row to disappear
        let predicate = NSPredicate(format: "exists == false")
        expectation(for: predicate, evaluatedWith: userRow, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertFalse(app.otherElements["UserRow Jane Smith"].exists)
    }
    
}
