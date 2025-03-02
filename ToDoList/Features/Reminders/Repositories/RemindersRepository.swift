//
//  RemindersRepository.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import Foundation
import FirebaseFirestore

public class RemindersRepository: ObservableObject {
    @Published
    var reminders = [Reminder]()
    
    func addReminder(_ reminder: Reminder) throws {
        try Firestore
            .firestore()
            .collection("reminders")
            .addDocument(from: reminder)
    }
}
