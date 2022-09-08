//
//  NotesDetailPresenter.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import Foundation

// MARK: - NotesDetailPresenter

final class NotesDetailPresenter: NotesDetailPresentable {
    
    // MARK: - View & Interactor & Router
    private weak var view: NotesDetailViewManageable?
    private var interactor: NotesDetailInputInteractable
    private var router: NotesDetailRoutable
    
    private let operationType: NotesDetailOperationType
    private weak var moduleDelegate: NotesDetailModuleDelegate?
    private let selectedNote: NoteModel?
    
    // MARK: - Init
    init(view: NotesDetailViewManageable? = nil,
         interactor: NotesDetailInputInteractable,
         router: NotesDetailRoutable,
         operationType: NotesDetailOperationType,
         moduleDelegate: NotesDetailModuleDelegate? = nil,
         selectedNote: NoteModel? = nil) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.operationType = operationType
        self.moduleDelegate = moduleDelegate
        self.selectedNote = selectedNote
    }
    
    func viewDidLoad() {
        view?.setupUI()
        getNoteDetails()
    }
    
    func didUserViewNotes(title: String?, content: String?) {
        view?.viewNote(title: title, content: content)
    }

    func userDidTapSaveButton(title: String?, content: String?) {
        switch operationType {
        case .add:
            interactor.createNote(title: title, content: content)
        case .update:
            interactor.updateNote(id: selectedNote?.id, title: title, content: content)
            break
        }
    }
    
    func getNoteDetails() {
        let title = selectedNote?.title
        let content = selectedNote?.content
        didUserViewNotes(title: title, content: content)
    }
    
    func editNote(title: String, content: String) {
        let title = selectedNote?.title
        let content = selectedNote?.content
        interactor.updateNote(id: selectedNote?.id, title: title, content: content)
    }
}

extension NotesDetailPresenter: NotesDetailOutputInteractable {
        
    func noteUpdated(note: NoteModel) {
        moduleDelegate?.notesUpdated(with: note)
        router.popToMain()
    }
    
    func selectedNoteUpdated(selectedNote: NoteModel) {
        moduleDelegate?.selectedNotesUpdated(with: selectedNote)
        router.popToMain()
    }
}

protocol NotesDetailPresentable {
    func viewDidLoad()
    func getNoteDetails()
    func editNote(title: String, content: String)
    func didUserViewNotes(title: String?, content: String?)
    func userDidTapSaveButton(title: String?, content: String?)
}

protocol NotesDetailOutputInteractable: AnyObject {
    func noteUpdated(note: NoteModel)
    func selectedNoteUpdated(selectedNote: NoteModel)
}


