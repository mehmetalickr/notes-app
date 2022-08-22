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
    func showNoteDetails(selectedNote: NoteModel)
    func removeNote(id: Int)
    }

protocol NotesInputInteractable: AnyObject {
    var presenter: NotesOutputInteractable! { get set }
    func fetchNotes()
    func deleteNoteFromStorage(id: Int)
}

protocol NotesOutputInteractable: AnyObject {
    func notesFetched(notes: [NoteModel])
}

protocol NotesRoutable: AnyObject {
    var viewController: UIViewController! { get set }
    func routeToAddNotesDetail(moduleDelegate: NotesDetailModuleDelegate?)
    func routeToUpdateNotesDetail(moduleDelegate: NotesDetailModuleDelegate?,
                                  selectedNote: NoteModel)
}

protocol NotesBuildable {
    static func build() -> NotesViewController
}

protocol SelectedNoteRoutable: NotesDetailRoutable {
    func showModule(view: UIViewController)
}



