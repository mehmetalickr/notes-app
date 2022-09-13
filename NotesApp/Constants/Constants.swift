//
//  Constants.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 17.08.2022.
//

import UIKit

// MARK: - Constants
enum Style {
    // MARK: - View Constants
    static let title = "Notes"
    static let buttonTitle = "Save"
    static let addNoteButtonImage = "note.text.badge.plus"
    static let viewBackgroundColor = UIColor.systemGray6
    // MARK: - Table View Constants
    static let tableViewCellReuseIdentifier = "noteCell"
    static let tableViewDeleteActionTitle = "Delete"
    static let tableViewBackgroundColor = UIColor.black
    static let tableViewRowHeight: CGFloat = 80
    static let tableViewCornerRadius: CGFloat = 10.0
    static let tableViewLeadingTrailingInset: CGFloat = 20
    static let tableViewTopInset: CGFloat = 200
    static let tableViewBottomInset: CGFloat = 50
    // MARK: - Title Text Field Constants
    static let titleTextFieldBackgroundColor = UIColor.systemGray6
    static let titleTextFieldFontSize: CGFloat = 20
    static let titleTextFieldCornerRadius: CGFloat = 10.0
    static let titleTextFieldBorderWidth: CGFloat = 1
    static let titleTextFieldHeight: CGFloat = 50
    static let titleTextFieldLeadingTrailingInset: CGFloat = 20
    // MARK: - Content Text View Constants
    static let contentTextViewFontSize: CGFloat = 15
    static let contentTextViewBackgroundColor = UIColor.systemGray6
    static let contentTextViewTopInset: CGFloat = -20
    static let contentTextFieldLeadingTrailingInset: CGFloat = 10
    // MARK: - Add Note Button Constants
    static let addNoteButtonSize: CGFloat = 20
    static let addNoteButtonTrailingInset: CGFloat = 30
    static let addNoteButtonTopInset: CGFloat = 10
}
