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
    
    func deleteNote(id: Int) {
        
    }
}
