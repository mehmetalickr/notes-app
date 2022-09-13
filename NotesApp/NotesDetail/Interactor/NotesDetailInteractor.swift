//
//  NotesDetailInteractor.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import Foundation

// MARK: - Protocol
protocol NotesDetailInputInteractable {
    func createNote(title: String, content: String)
    func updateNote(id: String, title: String, content: String)
}

final class NotesDetailInteractor {
    weak var output: NotesDetailOutputInteractable?
    var storage: UserDefaultsStorageInterface
    
    init(storage: UserDefaultsStorageInterface = UserDefaultsStorage.shared) {
        self.storage = storage
    }
}

// MARK: - NotesDetailInputInteractable
extension NotesDetailInteractor: NotesDetailInputInteractable {
    
    func createNote(title: String, content: String) {
        let note = NoteModel(
            id: UUID().uuidString,
            title: title,
            content: content
        )
        addNoteToStorage(note)
        output?.noteUpdated(note: note)
    }
    
    func updateNote(id: String, title: String, content: String) {
        let selectedNote = NoteModel(
            id: id,
            title: title,
            content: content
        )
        addUpdatedNoteToStorage(selectedNote)
        output?.selectedNoteUpdated(selectedNote: selectedNote)
    }
}

// MARK: - Private
private extension NotesDetailInteractor {
    func addNoteToStorage(_ note: NoteModel) {
        storage.appendNote(note: note)
    }
    
    func addUpdatedNoteToStorage(_ selectedNote: NoteModel) {
        storage.updateNote(with: selectedNote)
    }
}
