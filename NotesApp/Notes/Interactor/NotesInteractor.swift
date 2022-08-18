//
//  NotesInteractor.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 11.08.2022.
//

import Foundation

class NotesInteractor: NotesInputInteractable {
    weak var presenter: NotesOutputInteractable!
    
    func fetchNotes() {
        guard let ids = UserDefaults.standard.array(forKey: UserDefaultsKeys.notes_ids) as? [Int], let titles = UserDefaults.standard.array(forKey: UserDefaultsKeys.notes_titles) as? [String], let contents = UserDefaults.standard.array(forKey: UserDefaultsKeys.notes_contents) as? [String] else {
            presenter?.notesFetched(notes: [])
            
            return
        }
        
        var notes = [NoteModel]()
        
        for (index, (title, content)) in zip(titles, contents).enumerated() {
            notes.append(NoteModel(id: ids[index], title: title, content: content))
        }
        
        presenter?.notesFetched(notes: notes)
    }
    
    func deleteNote(id: Int) {
        var savedNotesIDs = UserDefaults.standard.array(forKey: UserDefaultsKeys.notes_ids) as? [Int] ?? []
        var savedNotesTitles = UserDefaults.standard.array(forKey: UserDefaultsKeys.notes_titles) as? [String] ?? []
        var savedNotesContents = UserDefaults.standard.array(forKey: UserDefaultsKeys.notes_contents) as? [String] ?? []
        
        guard let index = savedNotesIDs.firstIndex(where: { $0 == id }) else { return }
        
        savedNotesIDs.remove(at: index)
        savedNotesTitles.remove(at: index)
        savedNotesContents.remove(at: index)
        
        UserDefaults.standard.set(savedNotesIDs, forKey: UserDefaultsKeys.notes_ids)
        UserDefaults.standard.set(savedNotesTitles, forKey: UserDefaultsKeys.notes_titles)
        UserDefaults.standard.set(savedNotesContents, forKey: UserDefaultsKeys.notes_contents)
    }
}
