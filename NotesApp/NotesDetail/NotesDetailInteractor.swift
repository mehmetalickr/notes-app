//
//  NotesDetailInteractor.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import Foundation

// MARK: - Protocol
protocol NotesDetailInputInteractable {
    func createNote(note: NoteModel)
    func updateNote(id: String, title: String?, content: String?)
}

final class NotesDetailInteractor {
    weak var output: NotesDetailOutputInteractable?
    
    private let storage: UserDefaultsStorageInterface
    
    // MARK: - Init
    init(storage: UserDefaultsStorageInterface = UserDefaultsStorage.shared) {
        self.storage = storage
    }
}

// MARK: - NotesDetailInputInteractable
extension NotesDetailInteractor: NotesDetailInputInteractable {
    func createNote(note: NoteModel) {
        storage.appendNote(note: note)
        output?.didNoteUpdated(note: note)
    }
    
    func updateNote(id: String, title: String?, content: String?) {
        let selectedNote = NoteModel(
            id: id,
            title: title,
            content: content
        )
        storage.updateNote(with: selectedNote)
        output?.didNoteUpdated(note: selectedNote)
    }
}
