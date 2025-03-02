//
//  Reminder.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import Foundation

struct Reminder: Identifiable {
    let id = UUID()
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
