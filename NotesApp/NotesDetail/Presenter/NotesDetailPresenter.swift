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
    private let selectedNote: NoteModel?
    
    init(operationType: NotesDetailOperationType,
         moduleDelegate: NotesDetailModuleDelegate? = nil,
         selectedNote: NoteModel? = nil) {
        self.operationType = operationType
        self.moduleDelegate = moduleDelegate
        self.selectedNote = selectedNote
    }
    
    func userDidTapSaveButton(title: String?, content: String?) {
        switch operationType {
        case .add:
            interactor.createNote(title: title, content: content)
        case .update:
            interactor.updateNote(title: title, content: content)
            break
        }
    }
    
    func getNoteDetails() {
        let title = selectedNote?.title
        let content = selectedNote?.content
        view?.viewNote(title: title, content: content)
    }
    
    func editNote(title: String, content: String) {
//        let title = selectedNote?.title
//        let content = selectedNote?.content
//        interactor?.updateNote(title: title, content: content)
    }
}

extension NotesDetailPresenter: NotesDetailOutputInteractable {
        
    func noteUpdated(note: NoteModel) {
        moduleDelegate?.notesUpdated(with: note)
        router.popToMain()
    }
    
    func selectedNoteUpdated(selectedNote: NoteModel) {
        print("Selected note updated")
    }
}

protocol NotesDetailPresentable: AnyObject {
//    var view: NotesDetailViewManageable! { get set }
//    var interactor: NotesDetailInputInteractable! { get set }
//    var router: NotesDetailRoutable! { get set }
    
    func userDidTapSaveButton(title: String?, content: String?)
    func getNoteDetails()
    func editNote(title: String, content: String)
}

protocol NotesDetailOutputInteractable: AnyObject {
    func noteUpdated(note: NoteModel)
}


