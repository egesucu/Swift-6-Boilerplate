//
//  UserManager.swift
//  Swift 6 Boilerplate
//
//  Created by Sucu, Ege on 25.07.2024.
//

import Foundation

actor UserDataManager {
    private var users: [User] = []
    
    func addUser(_ user: User) {
        users.append(user)
    }
    
    func updateUser(_ user: User) {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index] = user
        }
    }
    
    func removeUser(with id: UUID) {
        users.removeAll { $0.id == id }
    }
    
    func getUsers() -> [User] {
        users
    }
}
