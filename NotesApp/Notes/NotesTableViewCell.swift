//
//  NotesTableViewCell.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 12.09.2022.
//

import UIKit

final class NotesTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Style.tableViewBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
