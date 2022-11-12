//
//  NotesConstants.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 13.09.2022.
//

import UIKit

// MARK: - Notes Constants
enum NotesStyle {
    // MARK: - Edit / Done Button Constants
    static let editButtonTitle = "Edit"
    static let doneButtonTitle = "Done"
    // MARK: - Table View Constants
    static let tableViewCellReuseIdentifier = "noteCell"
    static let tableViewDeleteActionTitle = "Delete"
    static let tableViewBackgroundColor = UIColor.black
    static let tableViewRowHeight: CGFloat = 80
    static let tableViewCornerRadius: CGFloat = 10.0
    static let tableViewLeadingInset: CGFloat = 20
    static let tableViewTrailingInset: CGFloat = -20
    static let tableViewTopInset: CGFloat = 200
    static let tableViewBottomInset: CGFloat = -50
    // MARK: - Add Note Button Constants
    static let addNoteButtonImage = "note.text.badge.plus"
    static let addNoteButtonSize: CGFloat = 20
    static let addNoteButtonTrailingInset: CGFloat = -30
    static let addNoteButtonTopInset: CGFloat = 10
}
