//
//  Repositories+Injection.swift
//  ToDoList
//
//  Created by ddudkin on 10.3.25..
//

import Foundation
import Factory

extension Container {
    public var remindersRepository: Factory<RemindersRepository> {
        self {
            RemindersRepository()
        }.singleton
    }
}
