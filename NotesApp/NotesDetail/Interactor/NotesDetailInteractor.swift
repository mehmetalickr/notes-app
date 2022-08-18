//
//  NotesDetailInteractor.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import Foundation

class NotesDetailInteractor: NotesDetailInputInteractable {
    weak var presenter: NotesDetailOutputInteractable!
    
    func saveNotes(note: NoteModel) {
        let savedNotesIDs = UserDefaults.standard.array(forKey: UserDefaultsKeys.notes_ids) as? [Int] ?? []
        var savedNotesTitles = UserDefaults.standard.array(forKey: UserDefaultsKeys.notes_titles) as? [String] ?? []
        var savedNotesContents = UserDefaults.standard.array(forKey: UserDefaultsKeys.notes_contents) as? [String] ?? []
        
        guard let index = savedNotesIDs.firstIndex(where: { $0 == note.id }) else { return }
        
        savedNotesTitles[index] = note.title
        savedNotesContents[index] = note.content
        
        UserDefaults.standard.set(savedNotesIDs, forKey: UserDefaultsKeys.notes_ids)
        UserDefaults.standard.set(savedNotesTitles, forKey: UserDefaultsKeys.notes_titles)
        UserDefaults.standard.set(savedNotesContents, forKey: UserDefaultsKeys.notes_contents)
    }
}
