//
//  NotesTableViewCellPresenter.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 13.09.2022.
//

import Foundation

// MARK: - NotesTableViewCellPresenter
class NotesTableViewCellPresenter {
    
    // MARK: - Init
    init(view: NotesTableViewCellViewable,
         note: NoteModel) {
        self.view = view
        self.note = note
    }
    
    // MARK: - Variables
    private weak var view: NotesTableViewCellViewable!
    private var note: NoteModel
}

// MARK: - NotesTableViewCellPresentable
extension NotesTableViewCellPresenter: NotesTableViewCellPresentable {
    func load() {
        view.setTitle(with: note)
    }
}
