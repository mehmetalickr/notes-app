//
//  UserDefaultsStorage.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 19.08.2022.
//

import Foundation

struct UserDefaultsStorage {
    @UserDefaultsWrapper(key: "notes", defaultValue: [NoteModel]())
    static var notes: [NoteModel]
    
    static func noteById(id: String) -> NoteModel? {
        notes.first { noteModel in
            noteModel.id == id
        }
    }
    
    static func updateNote(with updatedNote: NoteModel) {
        guard let index = notes.firstIndex(where: { noteModel in
            noteModel.id == updatedNote.id
        }) else { return }
        notes.remove(at: index)
        notes.insert(updatedNote, at: index)
    }
}
