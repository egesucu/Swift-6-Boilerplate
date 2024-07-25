//
//  UserListView.swift
//  Swift 6 Boilerplate
//
//  Created by Sucu, Ege on 25.07.2024.
//

import SwiftUI

struct UserListView: View {
    @State private var viewModel: UserViewModel
    @State private var showingAddUserSheet = false
    @State private var userToEdit: User?
    
    init(dataManager: UserDataManager) {
        _viewModel = State(initialValue: UserViewModel(dataManager: dataManager))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.users) { user in
                    UserRowView(user: user)
                        .onTapGesture {
                            userToEdit = user
                        }
                        .accessibilityIdentifier("UserRow \(user.name)")
                }
                .onDelete(perform: deleteUser)
            }
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add User") {
                        showingAddUserSheet = true
                    }
                    .accessibilityIdentifier("AddUser")
                }
            }
        }
        .sheet(isPresented: $showingAddUserSheet) {
            UserEditView(viewModel: viewModel, user: nil)
                .accessibilityIdentifier("UserEditForAdd")
        }
        .sheet(item: $userToEdit) { user in
            UserEditView(viewModel: viewModel, user: user)
                .accessibilityIdentifier("UserEdit \(user.name)")
        }
        .task {
            await viewModel.fetchUsers()
        }
    }
    
    private func deleteUser(at offsets: IndexSet) {
        Task { @MainActor in
            for index in offsets {
                let idToRemove = viewModel.users[index].id
                await viewModel.removeUser(with: idToRemove)
            }
        }
    }
}

#Preview {
    @Previewable var manager = UserDataManager()
    let user = User(name: "Dino", age: 25)
    Task {
        await manager.addUser(user)
    }
    
    return UserListView(dataManager: manager)
}
