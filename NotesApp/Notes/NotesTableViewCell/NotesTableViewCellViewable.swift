//
//  NotesTableViewCellViewable.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 18.09.2022.
//

import Foundation
 
protocol NotesTableViewCellViewable: AnyObject {
    func setTitle(with note: NoteModel)
}
