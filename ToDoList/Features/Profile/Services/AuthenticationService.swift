//
//  AuthenticationService.swift
//  ToDoList
//
//  Created by ddudkin on 16.3.25..
//

import Foundation
import FirebaseAuth
import Factory

public class AuthenticationService {
    @Injected(\.auth) private var auth
    @Published var user: User?
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        registerAuthStateHandler()
        signInAnnonymously()
    }
    
    func registerAuthStateHandler() {
        guard authStateHandler == nil else { return }
        
        authStateHandler = auth.addStateDidChangeListener({ auth, user in
            self.user = user
        })
    }
    
    func signInAnnonymously() {
        guard auth.currentUser == nil else {
            print("Someone is signed in with \(user?.providerID) and user ID \(user?.uid)")
            return
        }
        
        print("Nobody is signed in. Trying to sign in anonymously.")
        auth.signInAnonymously()
    }
    
    func signOut() {
        try? auth.signOut()
        signInAnnonymously()
    }
    
    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            signOut()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
