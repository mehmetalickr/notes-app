//
//  NotesDetailInteractor.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import Foundation

class NotesDetailInteractor: NotesDetailInputInteractable {
    weak var presenter: NotesDetailOutputInteractable!
    
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
        presenter.noteUpdated(note: note)
    }
    
    func updateNote(title: String?, content: String?) {
        print("Note Updated")
    }
    
    private func addNoteToStorage(_ note: NoteModel) {
        UserDefaultsStorage.notes.append(note)
    }
}