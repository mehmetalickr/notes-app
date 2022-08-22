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
        router.routeToAddNotesDetail(moduleDelegate: self)
    }
    
    func loadNotes() {
        interactor.fetchNotes()
    }
    
    func showNoteDetails(selectedNote: NoteModel) {
        router.routeToUpdateNotesDetail(moduleDelegate: self,
                                        selectedNote: selectedNote)
    }
    
    func removeNote(id: Int) {
        interactor.deleteNoteFromStorage(id: id)
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
