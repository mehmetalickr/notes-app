//
//  NotesDetailPresenter.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import Foundation

class NotesDetailPresenter: NotesDetailPresentable {
    weak var view: NotesDetailViewManageable!
    var interactor: NotesDetailInputInteractable!
    var router: NotesDetailRoutable!
    var note: NoteModel!
    
    func userDidTapSaveButton() {
        self.interactor.saveNotes(note: note)
    }
    
    func showNote() {
        guard let note = note else { return }
        view?.viewNotes(title: note.title, content: note.content)
    }
    
    func editNote(title: String, content: String) {
        guard var note = note else { return }
        note.title = title
        note.content = content
        interactor?.saveNotes(note: note)
    }
}

extension NotesDetailPresenter: NotesDetailOutputInteractable {
    func notesUpdated(notes: [NoteModel]) {
        
    }
}

