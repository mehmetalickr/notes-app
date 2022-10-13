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

// MARK: - NotesInputInteractable
final class NotesInteractor: NotesInputInteractable {
    weak var output: NotesOutputInteractable?
    private let storage: UserDefaultsStorageInterface
    
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
