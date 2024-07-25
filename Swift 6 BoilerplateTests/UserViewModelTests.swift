//
//  UserViewModelTests.swift
//  Swift 6 BoilerplateTests
//
//  Created by Sucu, Ege on 25.07.2024.
//

import Testing
@testable import Swift_6_Boilerplate

@Suite("User View Model Tests")
@MainActor
struct UserViewModelTests {
    
    @Test mutating func testUsers() async throws {
        let demoUser = User(name: "Demo", age: 25)
        let dataManager = UserDataManager()
        await dataManager.addUser(demoUser)
        let viewModel = UserViewModel(dataManager: dataManager)
        await viewModel.fetchUsers()
        
        #expect(!viewModel.users.isEmpty)
    }
    
    @Test func testAddUser() async throws {
        let demoUser = User(name: "Demo", age: 25)
        let dataManager = UserDataManager()
        let viewModel = UserViewModel(dataManager: dataManager)
        await viewModel.addUser(demoUser)
        let users = viewModel.users
        #expect(users.count == 1)
    }
    
    @Test func testUpdateUser() async throws {
        var demoUser = User(name: "Demo", age: 25)
        let dataManager = UserDataManager()
        let viewModel = UserViewModel(dataManager: dataManager)
        await viewModel.addUser(demoUser)
        demoUser.name = "Dino"
        await viewModel.updateUser(demoUser)
        let users = viewModel.users
        #expect(users.first?.name == "Dino")
    }
    
    @Test func testRemoveUser() async throws {
        let demoUser = User(name: "Demo", age: 25)
        let dataManager = UserDataManager()
        let viewModel = UserViewModel(dataManager: dataManager)
        await viewModel.addUser(demoUser)
        await viewModel.removeUser(with: demoUser.id)
        let users = viewModel.users
        #expect(users.isEmpty)
    }
}
