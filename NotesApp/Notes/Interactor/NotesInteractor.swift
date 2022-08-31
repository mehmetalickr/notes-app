//
//  NotesInteractor.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 11.08.2022.
//

import Foundation

class NotesInteractor: NotesInputInteractable {
    weak var presenter: NotesOutputInteractable!
    
    func fetchNotes() {
        presenter.notesFetched(notes: UserDefaultsStorage.notes)
    }
    
    func deleteNoteFromStorage(id: Int) {
        UserDefaultsStorage.notes.remove(at: id)
    }
}

protocol NotesInputInteractable: AnyObject {
    var presenter: NotesOutputInteractable! { get set }
    func fetchNotes()
    func deleteNoteFromStorage(id: Int)
}

protocol NotesOutputInteractable: AnyObject {
    func notesFetched(notes: [NoteModel])
}
