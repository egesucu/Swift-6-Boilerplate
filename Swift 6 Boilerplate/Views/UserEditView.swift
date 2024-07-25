//
//  UserEditView.swift
//  Swift 6 Boilerplate
//
//  Created by Sucu, Ege on 25.07.2024.
//

import SwiftUI

struct UserEditView: View {
    @Environment(\.dismiss) private var dismiss
    let viewModel: UserViewModel
    let user: User?
    
    @State private var name: String
    @State private var age: String
    
    init(viewModel: UserViewModel, user: User?) {
        self.viewModel = viewModel
        self.user = user
        _name = State(initialValue: user?.name ?? "")
        _age = State(initialValue: user?.age.description ?? "")
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .accessibilityIdentifier("NameTextField")
                TextField("Age", text: $age)
                    .keyboardType(.numberPad)
                    .accessibilityIdentifier("AgeTextField")
            }
            .navigationTitle(user == nil ? "Add User" : "Edit User")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            await saveUser()
                        }
                    }
                    .accessibilityIdentifier("SaveUserButton")
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .accessibilityIdentifier("CancelSaveButton")
                }
            }
        }
    }
    
    private func saveUser() async {
        guard let ageInt = Int(age) else { return }
        
        if let existingUser = user {
            let updatedUser = User(id: existingUser.id, name: name, age: ageInt)
            await viewModel.updateUser(updatedUser)
        } else {
            let newUser = User(name: name, age: ageInt)
            await viewModel.addUser(newUser)
        }
        
        dismiss()
    }
}

#Preview {
    @Previewable var user = User(name: "Dino", age: 25)
    @Previewable var viewModel = UserViewModel(dataManager: .init())
    UserEditView(viewModel: viewModel, user: user)
}
