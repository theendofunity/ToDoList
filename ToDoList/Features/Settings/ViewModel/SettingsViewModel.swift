//
//  SettingsViewModel.swift
//  ToDoList
//
//  Created by ddudkin on 12.3.25..
//

import Combine
import Factory
import FirebaseAuth
import Foundation

class SettingsViewModel: ObservableObject {
    @Injected(\.authenticationService)
    private var authenticationService
    
    @Published var user: User?
    @Published var displayName = ""
    
    @Published var isGuestUser = false
    
    @Published var loggedInAs = ""
    
    init() {
        authenticationService.$user
            .assign(to: &$user)
        
        $user
            .compactMap { user in
                user?.isAnonymous
            }
            .assign(to: &$isGuestUser)
        
        $user
            .compactMap { user in
                user?.displayName ?? user?.email ?? ""
            }
            .assign(to: &$displayName)
        
        Publishers.CombineLatest($isGuestUser, $displayName)
            .map { isGuest, displayName in
                isGuest
                ? "You're using the app as a guest"
                : "Logged in as \(displayName)"
            }
            .assign(to: &$loggedInAs)
    }
    
    func signOut() {
        authenticationService.signOut()
    }
}
