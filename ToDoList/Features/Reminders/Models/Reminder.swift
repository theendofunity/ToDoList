//
//  Reminder.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import Foundation
import FirebaseFirestore

struct Reminder: Identifiable, Codable {
    @DocumentID
    var id: String?
    
    var title: String
    var isCompleted: Bool = false
}

extension Reminder {
  static let samples = [
    Reminder(title: "Build sample app", isCompleted: true),
    Reminder(title: "Create tutorial"),
    Reminder(title: "???"),
    Reminder(title: "PROFIT!"),
  ]
}

extension Reminder {
  static let collectionName = "reminders"
}
