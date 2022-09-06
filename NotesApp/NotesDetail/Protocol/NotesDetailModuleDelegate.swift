//
//  NotesDetailModuleDelegate.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 31.08.2022.
//

import Foundation

protocol NotesDetailModuleDelegate: AnyObject {
    func notesUpdated(with note: NoteModel)
    func selectedNotesUpdated(with selectedNote: NoteModel)
}
