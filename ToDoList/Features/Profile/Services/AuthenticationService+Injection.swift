//
//  AuthenticationService+Injection.swift
//  ToDoList
//
//  Created by ddudkin on 16.3.25..
//

import Foundation
import Factory

extension Container {
    public var authenticationService: Factory<AuthenticationService> {
        self {
            AuthenticationService()
        }.singleton
    }
}
