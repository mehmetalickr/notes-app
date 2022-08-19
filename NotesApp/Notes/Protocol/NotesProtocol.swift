//
//  NotesProtocol.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 12.08.2022.
//

import UIKit

protocol NotesViewManageable: AnyObject {
    var presenter: NotesPresentable! { get set }
    func viewNotes(notes: [NoteModel])
}

protocol NotesPresentable: AnyObject {
    var view: NotesViewManageable! { get set }
    var interactor: NotesInputInteractable! { get set }
    var router: NotesRoutable! { get set }
    
    func userDidTapAddNoteButton()
    func loadNotes()
    func removeNote(id: Int)
    }

protocol NotesInputInteractable: AnyObject {
    var presenter: NotesOutputInteractable! { get set }
    func fetchNotes()
    func deleteNote(id: Int)
}

protocol NotesOutputInteractable: AnyObject {
    func notesFetched(notes: [NoteModel])
}

protocol NotesRoutable: AnyObject {
    var viewController: UIViewController! { get set }
    func showNotesDetail(operationType: NotesDetailOperationType,
                         moduleDelegate: NotesDetailModuleDelegate?)
}

protocol NotesBuildable {
    static func build() -> NotesViewController
}



