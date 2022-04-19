//
//  StorageManager.swift
//  Notes
//
//  Created by Ирина on 19.04.2022.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "Notes"
    
    private init() {}
    
    func save(note: Notes) {
        var notes = fetchNotes()
        notes.append(note)
        guard let data = try? JSONEncoder().encode(notes) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func fetchNotes() -> [Notes] {
        guard let data = userDefaults.data(forKey: key) else { return [] }
        guard let notes = try? JSONDecoder().decode([Notes].self, from: data) else { return [] }
        return notes
        
    }
    
    func deleteNote(at index: Int) {
        var notes = fetchNotes()
        notes.remove(at: index)
        guard let data = try? JSONEncoder().encode(notes) else { return }
        userDefaults.set(data, forKey: key)
    }
}
