//
//  RemindersListViewModel.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import Foundation

final class RemindersListViewModel: ObservableObject {
    @Published var reminders: [Reminder] = Reminder.samples
    
    func addReminder(_ reminder: Reminder) {
        reminders.append(reminder)
    }
    
    func toggleCompleted(_ reminder: Reminder) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index].isCompleted.toggle()
        }
    }
}
