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
    private let operationType: NotesDetailOperationType
    private weak var moduleDelegate: NotesDetailModuleDelegate?
    
    init(operationType: NotesDetailOperationType,
         moduleDelegate: NotesDetailModuleDelegate? = nil) {
        self.operationType = operationType
        self.moduleDelegate = moduleDelegate
    }
    
    func userDidTapSaveButton(title: String?, content: String?) {
        switch operationType {
        case .add:
            interactor.createNote(title: title, content: content)
        case .update:
            break
        }
//        self.interactor.saveNotes(note: note)
    }
    
    func showNote() {
//        view?.viewNotes(title: note.title, content: note.content)
    }
    
    func editNote(title: String, content: String) {
//        note.title = title
//        note.content = content
//        interactor?.saveNotes(note: note)
    }
}

extension NotesDetailPresenter: NotesDetailOutputInteractable {
    func noteUpdated(note: NoteModel) {
        moduleDelegate?.notesUpdated(with: note)
        router.popToMain()
    }
}

