//
//  NotesPresenter.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 11.08.2022.
//

import Foundation
import UIKit

// MARK: - NotesPresenter

final class NotesPresenter: NotesPresentable {
    
    // MARK: - View & Interactor & Router
    weak var view: NotesViewManageable?
    var interactor: NotesInputInteractable?
    var router: NotesRoutable?
    
    var notes: [NoteModel] = []
    
    func viewDidLoad() {
        view?.setTitle("Notes")
        view?.setBackgroundColor(Style.viewBackgroundColor)
    }
    
    func viewWillAppear() {
        view?.viewWillAppear(false)
    }
    
    func didSetupUI() {
        view?.setupUI()
    }
    
    func didSetupTableView() {
        view?.setupTableView()
    }
    func didSetTableViewDelegates() {
        view?.setTableViewDelegates()
    }
    func didSetupAddNoteButton() {
        view?.setupAddNoteButton()
    }
    
    func didTableViewDeselectRow(at indexPath: IndexPath) {
        view?.tableViewDeselectRow(at: indexPath)
    }
    
    func didTableViewDeleteRows(at indexPath: IndexPath) {
        view?.tableViewDeleteRows(at: indexPath)
    }

    func userDidTapAddNoteButton() {
        router?.routeToAddNotesDetail(moduleDelegate: self)
    }
    
    func loadNotes() {
        interactor?.fetchNotes()
    }
    
    func showNoteDetails(selectedNote: NoteModel) {
        router?.routeToUpdateNotesDetail(moduleDelegate: self,
                                        selectedNote: selectedNote)
    }
    
    func removeNote(id: Int) {
        interactor?.deleteNoteFromStorage(id: id)
    }
}

extension NotesPresenter: NotesOutputInteractable {
    func notesFetched(notes: [NoteModel]) {
        view?.reloadTableView()
        self.notes = notes
    }
}

extension NotesPresenter: NotesDetailModuleDelegate {
    func notesUpdated(with note: NoteModel) {
        interactor?.fetchNotes()
    }
    func selectedNotesUpdated(with selectedNote: NoteModel) {
        interactor?.fetchNotes()
    }
}

protocol NotesPresentable: AnyObject {
    var interactor: NotesInputInteractable? { get set }
    var router: NotesRoutable? { get set }
    var notes: [NoteModel] { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func didSetupUI()
    func didSetupTableView()
    func didSetTableViewDelegates()
    func didSetupAddNoteButton()
    func didTableViewDeselectRow(at indexPath: IndexPath)
    func didTableViewDeleteRows(at indexPath: IndexPath)
    func userDidTapAddNoteButton()
    func loadNotes()
    func showNoteDetails(selectedNote: NoteModel)
    func removeNote(id: Int)
}
