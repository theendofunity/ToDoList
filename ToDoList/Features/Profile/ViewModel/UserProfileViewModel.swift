//
//  UserProfileViewModel.swift
//  ToDoList
//
//  Created by ddudkin on 12.3.25..
//

import Foundation

final class UserProfileViewModel: ObservableObject {
    var displayName: String {
        "name"
    }
    
    var email: String {
        "email@example.com"
    }
    
    var uid: String? {
        "uid"
    }
    
    var provider: String {
        "provider"
    }
    
    var isGuestUser: Bool {
        false
    }
    
    var isVerified: Bool {
        true
    }
}
