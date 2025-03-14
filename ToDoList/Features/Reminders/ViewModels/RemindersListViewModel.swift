//
//  RemindersListViewModel.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import Foundation
import Factory

final class RemindersListViewModel: ObservableObject {
    @Published var reminders: [Reminder] = []
    @Published var errorMessage: String?
    
    @Injected(\.remindersRepository) private var remindersRepository
    
    init() {
        remindersRepository
            .$reminders
            .assign(to: &$reminders)
    }
    
    func addReminder(_ reminder: Reminder) {
        do {
            try remindersRepository.addReminder(reminder)
            errorMessage = nil
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func setCompleted(_ reminder: Reminder, isCompleted: Bool) {
        var editedReminder = reminder
        editedReminder.isCompleted = isCompleted
        update(reminder: editedReminder)
    }
    
    func update(reminder: Reminder) {
        do {
            try remindersRepository.update(reminder)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func delete(_ reminder: Reminder) {
        remindersRepository.remove(reminder)
    }
}
