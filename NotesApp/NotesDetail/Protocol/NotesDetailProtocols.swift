//
//  NotesDetailProtocol.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import UIKit

protocol NotesDetailModuleDelegate: AnyObject {
    func noteSaved(note: NoteModel)
}

protocol NotesDetailViewManageable: AnyObject {
    var presenter: NotesDetailPresentable! { get set }
    func viewNotes(title: String, content: String)
}

protocol NotesDetailPresentable: AnyObject {
    var view: NotesDetailViewManageable! { get set }
    var interactor: NotesDetailInputInteractable! { get set }
    var router: NotesDetailRoutable! { get set }
    
    func userDidTapSaveButton()
    func showNote()
    func editNote(title: String, content: String)
}

protocol NotesDetailInputInteractable: AnyObject {
    var presenter: NotesDetailOutputInteractable! { get set }
    func saveNotes(note: NoteModel)
}

protocol NotesDetailOutputInteractable: AnyObject {
    func notesUpdated(notes: [NoteModel])
}

protocol NotesDetailRoutable: AnyObject {
    var viewController: UIViewController! { get set }
}

protocol NotesDetailBuildable {
    static func build() -> NotesDetailViewController
}
