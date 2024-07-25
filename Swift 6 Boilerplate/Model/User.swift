//
//  User.swift
//  Swift 6 Boilerplate
//
//  Created by Sucu, Ege on 25.07.2024.
//

import Foundation

struct User: Identifiable, Sendable {
    
    var id: UUID
    var name: String
    var age: Int
    
    init(id: UUID = UUID(), name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
}
