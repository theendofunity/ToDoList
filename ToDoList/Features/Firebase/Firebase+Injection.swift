//
//  Firebase+Injection.swift
//  ToDoList
//
//  Created by ddudkin on 10.3.25..
//

import Foundation
import Factory
import FirebaseAuth
import FirebaseFirestore

extension Container {
    public var useEmulator: Factory<Bool> {
        Factory(self) {
            let value =  UserDefaults.standard.bool(forKey: "useEmulator")
            print("Using the emulator: \(value == true ? "YES" : "NO")")
            return value
        }.singleton
    }
    
    public var firestore: Factory<Firestore> {
        Factory(self) {
            var environment = ""
            if Container.shared.useEmulator() {
                let settings = Firestore.firestore().settings
                settings.host = "localhost:8080"
                settings.cacheSettings = MemoryCacheSettings()
                settings.isSSLEnabled = false
                environment = "to use the local emulator on \(settings.host)"
                
                
                Firestore.firestore().settings = settings
                Auth.auth().useEmulator(withHost: "localhost", port: 9099)
            }
            else {
                environment = "to use the Firebase backend"
            }
            print("Configuring Cloud Firestore \(environment).")
            return Firestore.firestore()
        }.singleton
    }
}
