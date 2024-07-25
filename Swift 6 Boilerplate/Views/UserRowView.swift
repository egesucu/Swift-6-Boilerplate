//
//  UserRowView.swift
//  Swift 6 Boilerplate
//
//  Created by Sucu, Ege on 25.07.2024.
//

import SwiftUI

struct UserRowView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.name)
                .font(.headline)
                .accessibilityIdentifier("UserNameText")
            Text("Age: \(user.age)")
                .font(.subheadline)
                .accessibilityIdentifier("UserAgeText")
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("UserRow \(user.name)")
    }
}

#Preview {
    @Previewable var user = User(name: "Dino", age: 25)
    UserRowView(user: user)
}
