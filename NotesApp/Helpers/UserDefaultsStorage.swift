//
//  UserDefaultsStorage.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 19.08.2022.
//

import Foundation

// MARK: - Protocol
protocol UserDefaultsStorageInterface {
    var notes: [NoteModel] { get }
    func appendNote(note: NoteModel)
    func removeNote(id: Int)
    func noteById(id: String) -> NoteModel?
    func updateNote(with updatedNote: NoteModel)
}

// MARK: - UserDefaultsStorageInterface
final class UserDefaultsStorage: UserDefaultsStorageInterface {
    static var shared: UserDefaultsStorage = UserDefaultsStorage()
    @UserDefaultsWrapper(key: "notes", defaultValue: [NoteModel]())
    private var storedNotes: [NoteModel]
    
    var notes: [NoteModel] {
        storedNotes
    }
    
    func noteById(id: String) -> NoteModel? {
        storedNotes.first { noteModel in
            noteModel.id == id
        }
    }
    
    func updateNote(with updatedNote: NoteModel) {
        guard let index = storedNotes.firstIndex(where: { noteModel in
            noteModel.id == updatedNote.id
        }) else { return }
        storedNotes[index] = updatedNote
    }
    
    func appendNote(note: NoteModel) {
        storedNotes.append(note)
    }
    
    func removeNote(id: Int) {
        storedNotes.remove(at: id)
    }
}
