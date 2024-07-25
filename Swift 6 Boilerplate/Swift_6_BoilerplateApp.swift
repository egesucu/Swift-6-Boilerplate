//
//  Swift_6_BoilerplateApp.swift
//  Swift 6 Boilerplate
//
//  Created by Sucu, Ege on 25.07.2024.
//

import SwiftUI
import SwiftData

@main
struct Swift_6_BoilerplateApp: App {

    var body: some Scene {
        WindowGroup {
            UserListView(dataManager: .init())
        }
    }
}
