//
//  NotesProtocol.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 12.08.2022.
//

import UIKit

protocol PresenterToViewProtocol: AnyObject {
    func viewNotes(notes: [NoteModel])
}

protocol ViewToPresenterProtocol: AnyObject {
    var view: PresenterToViewProtocol? { get set }
    var interactor: PresenterToInteractorProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }
    
    func addNote()
    func loadNotes()
    func showNoteDetails(selectedNote: NoteModel)
    func removeNote(id: Int)
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter: InteractorToPresenterProtocol? { get set }
    
    func didTapSave(note: NoteModel)
    func fetchNotes()
    func deleteNote(id: Int)
}

protocol InteractorToPresenterProtocol: AnyObject {
    func notesFetched(notes: [NoteModel])
}

protocol PresenterToRouterProtocol: AnyObject {
    func routeToNoteDetails(selectedNote: NoteModel)
}

protocol ViewToRouterProtocol: AnyObject {
    var view: RouterToViewProtocol { get set }
}

protocol RouterToViewProtocol: AnyObject {
    func showAlert(alert: UIAlertController)
    func showModule(view: UIViewController)
}

