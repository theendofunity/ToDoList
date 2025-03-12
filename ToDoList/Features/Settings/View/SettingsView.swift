//
//  SettingsView.swift
//  ToDoList
//
//  Created by ddudkin on 12.3.25..
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = SettingsViewModel()
    @State var isShowSignUpDialogPresented = false
    
    private func signUp() {
        isShowSignUpDialogPresented = true
    }
    
    private func signOut() {
        viewModel.signOut()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        Label("Account", systemImage: "person.circle")
                    }
                }
                
                Section {
                    if viewModel.isGuestUser {
                        Button(action: signUp) {
                            HStack {
                                Spacer()
                                Text("Sign up")
                                Spacer()
                            }
                        }
                    } else {
                        Button(action: signOut) {
                            HStack {
                                Spacer()
                                Text("Sign out")
                                Spacer()
                            }
                        }
                    }
                } footer: {
                    HStack {
                        Spacer()
                        Text(viewModel.loggedInAs)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: { dismiss() }) {
                        Text("Done")
                    }
                }
            }
            .sheet(isPresented: $isShowSignUpDialogPresented) {
                AuthenticationView()
            }
        }
    }
}

#Preview {
    SettingsView()
}
