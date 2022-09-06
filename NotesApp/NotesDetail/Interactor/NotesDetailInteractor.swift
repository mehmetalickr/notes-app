//
//  NotesDetailInteractor.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import Foundation

final class NotesDetailInteractor: NotesDetailInputInteractable {
    weak var presenter: NotesDetailOutputInteractable?
    
    func createNote(title: String?, content: String?) {
        guard let title = title,
              let content = content else {
            return
        }
        let note = NoteModel(
            id: UUID().uuidString,
            title: title,
            content: content
        )
        addNoteToStorage(note)
        presenter?.noteUpdated(note: note)
    }
    
    func updateNote(title: String?, content: String?) {
        guard let title = title,
              let content = content else {
            return
        }
        let selectedNote = NoteModel(
            id: UUID().uuidString,
            title: title,
            content: content
        )
        addUpdatedNoteToStorage(selectedNote)
        presenter?.selectedNoteUpdated(selectedNote: selectedNote)
    }
    
    private func addNoteToStorage(_ note: NoteModel) {
        UserDefaultsStorage.notes.append(note)
    }
    
    private func addUpdatedNoteToStorage(_ selectedNote: NoteModel) {
        UserDefaultsStorage.notes.append(selectedNote)
    }
}

protocol NotesDetailInputInteractable: AnyObject {
    var presenter: NotesDetailOutputInteractable? { get set }
    
    func createNote(title: String?, content: String?)
    func updateNote(title: String?, content: String?)
}
