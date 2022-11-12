//
//  NotesDetailPresenter.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import Foundation

// MARK: - Protocols
protocol NotesDetailPresentable {
    func viewDidLoad()
    func getNoteDetails()
    func editNote(title: String, content: String)
    func didUserViewNotes(title: String?, content: String?)
    func didSetTitleTextFieldsCharacterLimit(text: String?,
                                             shouldChangeCharactersIn range: NSRange,
                                             replacementString string: String) -> Bool
    func userDidSaveNote(title: String?, content: String?)
}

protocol NotesDetailOutputInteractable: AnyObject {
    func didNoteUpdated(note: NoteModel)
}

// MARK: - NotesDetailPresenter
final class NotesDetailPresenter {
    
    // MARK: - View & Interactor & Router
    private weak var view: NotesDetailViewManageable?
    private let interactor: NotesDetailInputInteractable
    private let operationType: NotesDetailOperationType
    private weak var moduleDelegate: NotesDetailModuleDelegate?
    private var selectedNote: NoteModel?
    
    // MARK: - Init
    init(view: NotesDetailViewManageable? = nil,
         interactor: NotesDetailInputInteractable,
         operationType: NotesDetailOperationType,
         moduleDelegate: NotesDetailModuleDelegate? = nil,
         selectedNote: NoteModel? = nil) {
        self.view = view
        self.interactor = interactor
        self.operationType = operationType
        self.moduleDelegate = moduleDelegate
        self.selectedNote = selectedNote
    }
}

// MARK: - NotesDetailPresentable
extension NotesDetailPresenter: NotesDetailPresentable {
    func viewDidLoad() {
        view?.setupTitleTextFieldViewHierarchy()
        view?.setupContentTextViewHierarchy()
        view?.setupConstraints()
        view?.setupTitleTextField()
        view?.setupContentTextView()
        getNoteDetails()
    }
    
    func didUserViewNotes(title: String?, content: String?) {
        view?.setTitleTextFieldText(with: title)
        view?.setContentTextViewText(with: content)
    }
    
    func userDidSaveNote(title: String?, content: String?) {
        switch operationType {
        case .add:
            if let selectedNote = selectedNote {
                updateNote(selectedNoteID: selectedNote.id, title: title, content: content)
            } else {
                let note = NoteModel(
                    id: UUID().uuidString,
                    title: title,
                    content: content
                )
                interactor.createNote(note: note)
            }
        case .update:
            guard let id = selectedNote?.id else { return }
            updateNote(selectedNoteID: id, title: title, content: content)
        }
    }
    
    func getNoteDetails() {
        let title = selectedNote?.title
        let content = selectedNote?.content
        didUserViewNotes(title: title, content: content)
    }
    
    func editNote(title: String, content: String) {
        guard let id = selectedNote?.id,
              let title = selectedNote?.title,
              let content = selectedNote?.content else {
            return
        }
        interactor.updateNote(id: id, title: title, content: content)
    }
    
    func didSetTitleTextFieldsCharacterLimit(text: String?,
                                             shouldChangeCharactersIn range: NSRange,
                                             replacementString string: String) -> Bool {
        guard let text = text,
              let rangeOfTextToReplace = Range(range, in: text) else {
            return false
        }
        let substringToReplace = text[rangeOfTextToReplace]
        let count = text.count - substringToReplace.count + string.count
        return count <= NotesDetailStyle.titleTextFieldMaxCharacters
    }
    
    private func updateNote(selectedNoteID: String, title: String?, content: String?) {
        interactor.updateNote(id: selectedNoteID, title: title, content: content)
    }
}

// MARK: - NotesDetailOutputInteractable
extension NotesDetailPresenter: NotesDetailOutputInteractable {
    func didNoteUpdated(note: NoteModel) {
        moduleDelegate?.notesUpdated(with: note)
        self.selectedNote = note
    }
}
