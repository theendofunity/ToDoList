//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import Factory

class AppDelegate: NSObject, UIApplicationDelegate {
    @LazyInjected(\.authenticationService)
    private var authenticationService
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        authenticationService.signInAnnonymously()
        return true
    }
}

@main
struct ToDoListApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RemindersListView()
            }
            .navigationTitle("Reminders")
        }
    }
}
