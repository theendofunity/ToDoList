//
//  SettingsViewModel.swift
//  ToDoList
//
//  Created by ddudkin on 12.3.25..
//

import Foundation

final class SettingsViewModel: ObservableObject {
    var isGuestUser = true
    var loggedInAs: String {
        "Logged in as guest"
    }
    func signOut() {
        
    }
}
