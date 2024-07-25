//
//  UserViewModel.swift
//  Swift 6 Boilerplate
//
//  Created by Sucu, Ege on 25.07.2024.
//

import Foundation
import Observation

@Observable
@MainActor
class UserViewModel {
    private let dataManager: UserDataManager
    private(set) var users: [User] = []
    
    init(dataManager: UserDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchUsers() async {
        users = await dataManager.getUsers()
    }
    
    func addUser(_ user: User) async {
        await dataManager.addUser(user)
        await fetchUsers()
    }
    
    func updateUser(_ user: User) async {
        await dataManager.updateUser(user)
        await fetchUsers()
    }
    
    func removeUser(with id: UUID) async {
        await dataManager.removeUser(with: id)
        await fetchUsers()
    }
}
