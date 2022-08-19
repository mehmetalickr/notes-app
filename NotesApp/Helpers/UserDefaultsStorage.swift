//
//  UserDefaultsStorage.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 19.08.2022.
//

import Foundation

struct UserDefaultsStorage {
    @UserDefaultsWrapper(key: "notes", defaultValue: [NoteModel]())
    static var notes: [NoteModel]
}
