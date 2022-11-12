//
//  NotesTableViewCellPresenter.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 13.09.2022.
//

import Foundation

// MARK: - NotesTableViewCellViewable
protocol NotesTableViewCellViewable: AnyObject {
    func setTitle(with text: String?)
}

// MARK: - NotesTableViewCellPresenter
final class NotesTableViewCellPresenter {
    
    // MARK: - Init
    init(view: NotesTableViewCellViewable,
         note: NoteModel) {
        self.view = view
        self.note = note
    }
    
    // MARK: - Variables
    private weak var view: NotesTableViewCellViewable!
    private var note: NoteModel
    
    var titlePlaceholder: String? {
        if note.title == nil || note.title == "" {
            return "Başlıksız"
        }
        return note.title
    }
}

// MARK: - NotesTableViewCellPresentable
extension NotesTableViewCellPresenter: NotesTableViewCellPresentable {
    func load() {
        view.setTitle(with: titlePlaceholder)
    }
}
