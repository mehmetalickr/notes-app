//
//  NotesInteractor.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 11.08.2022.
//

import Foundation

// MARK: - Protocols
protocol NotesInputInteractable {
    func fetchNotes()
    func deleteNoteFromStorage(id: Int)
}

protocol NotesOutputInteractable: AnyObject {
    func notesFetched(notes: [NoteModel])
}

// MARK: - NotesInputInteractable
final class NotesInteractor: NotesInputInteractable {
    weak var output: NotesOutputInteractable?
    var storage: UserDefaultsStorageInterface
    
    init(storage: UserDefaultsStorageInterface = UserDefaultsStorage.shared) {
        self.storage = storage
    }
    
    func fetchNotes() {
        output?.notesFetched(notes: storage.notes)
    }
    
    func deleteNoteFromStorage(id: Int) {
        storage.removeNote(id: id)
    }
}
