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
    
    func userDidTapAddNoteButton() {
        router.showNotesDetail(operationType: .add,
                               moduleDelegate: self)
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
        view.viewNotes(notes: notes)
    }
}

extension NotesPresenter: NotesDetailModuleDelegate {
    func notesUpdated(with note: NoteModel) {
        interactor.fetchNotes()
    }
}
