//
//  RemindersRepository.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import FirebaseFirestore
import Foundation

public class RemindersRepository: ObservableObject {
    @Published
    var reminders = [Reminder]()
    
    private var listenerRegistration: ListenerRegistration?
    
    init() {
        subscribe()
    }
    
    deinit {
        unsubscribe()
    }
    
    func addReminder(_ reminder: Reminder) throws {
        try Firestore
            .firestore()
            .collection(Reminder.collectionName)
            .addDocument(from: reminder)
    }
    
    func subscribe() {
        guard listenerRegistration == nil else {
            return
        }
        
        let query = Firestore.firestore().collection(Reminder.collectionName)
        
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
        
        try Firestore
            .firestore()
            .collection(Reminder.collectionName)
            .document(documntId)
            .setData(from: reminder, merge: true)
    }
    
    func remove(_ reminder: Reminder) {
        guard let documntId = reminder.id else {
            return
        }
        
        Firestore
            .firestore()
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
