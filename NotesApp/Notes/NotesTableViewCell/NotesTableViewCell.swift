//
//  NotesTableViewCell.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 12.09.2022.
//

import UIKit

// MARK: - NotesTableViewCell
final class NotesTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = NotesStyle.tableViewBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var presenter: NotesTableViewCellPresentable! {
        didSet {
            presenter.load()
        }
    }
}

// MARK: - NotesTableViewCellTitleViewable
extension NotesTableViewCell: NotesTableViewCellViewable {
    
    func setTitle(with note: NoteModel) {
        textLabel?.text = note.title
    }
}
