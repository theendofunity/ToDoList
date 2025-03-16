//
//  RemindersRepository.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import FirebaseFirestore
import Foundation
import Factory
import FirebaseAuth
import Combine

public class RemindersRepository: ObservableObject {
    @Published
    var reminders = [Reminder]()
    
    @Published
    var user: User? = nil
    
    @Injected(\.firestore) var firestore
    @Injected(\.authenticationService) var authenticationService
    
    private var listenerRegistration: ListenerRegistration?
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        authenticationService.$user
            .assign(to: &$user)
        subscribe()
        
        $user.sink { user in
            self.unsubscribe()
            self.subscribe(user: user)
        }
        .store(in: &cancelables)
    }
    
    deinit {
        unsubscribe()
    }
    
    func addReminder(_ reminder: Reminder) throws {
        var mutableReminder = reminder
        mutableReminder.userId = user?.uid
        
        try firestore
            .collection(Reminder.collectionName)
            .addDocument(from: mutableReminder)
    }
    
    func subscribe(user: User? = nil) {
        guard listenerRegistration == nil, let localUser = user ?? self.user  else {
            return
        }
        
        let query = firestore.collection(Reminder.collectionName)
            .whereField("userId", isEqualTo: localUser.uid)
        
        listenerRegistration = query
            .addSnapshotListener { [weak self] snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("No documents")
                    return
                }
                
                print("Mapping \(documents.count) documents")
                self?.reminders =  documents.compactMap { documentSnapshot in
                    do {
                        return try documentSnapshot.data(as: Reminder.self)
                    }
                    catch {
                        print("Error while trying to map document \(documentSnapshot.documentID): \(error.localizedDescription)")
                        return nil
                    }
                }
            }
    }
    
    func update(_ reminder: Reminder) throws {
        guard let documntId = reminder.id else {
            return
        }
        
        try firestore
            .collection(Reminder.collectionName)
            .document(documntId)
            .setData(from: reminder, merge: true)
    }
    
    func remove(_ reminder: Reminder) {
        guard let documntId = reminder.id else {
            return
        }
        
        firestore
            .collection(Reminder.collectionName)
            .document(documntId)
            .delete()
    }
    
    private func unsubscribe() {
        guard let listenerRegistration else {
            return
        }
        
        listenerRegistration.remove()
        self.listenerRegistration = nil
    }
}
