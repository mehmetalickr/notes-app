//
//  NotesPresenter.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 11.08.2022.
//

import Foundation

class NotesPresenter: NotesPresentable {
    weak var view: NotesViewManageable!
    var interactor: NotesInputInteractable!
    var router: NotesRoutable!
    private var notes = [NoteModel]()
    func userDidTapAddNoteButton() {
        router.showNotesDetail()
    }
    
    func loadNotes() {
        interactor.fetchNotes()
    }
    
    func removeNote(id: Int) {
        interactor.deleteNote(id: id)
    }
}

extension NotesPresenter: NotesOutputInteractable {
    func notesFetched(notes: [NoteModel]) {
        self.notes = notes
        view.viewNotes(notes: notes)
    }
}
