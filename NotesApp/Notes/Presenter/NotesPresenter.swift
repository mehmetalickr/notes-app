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
    var interactor: NotesInputInteractable
    var router: NotesRoutable
        
    private var notes: [NoteModel] = []
    
    // MARK: - Init
    init(view: NotesViewManageable? = nil,
         interactor: NotesInputInteractable,
         router: NotesRoutable
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.setTitle("Notes")
        view?.setBackgroundColor(Style.viewBackgroundColor)
        view?.setupUI()
    }
    
    func viewWillAppear() {
        loadNotes()
    }
    
    func numberOfNote() -> Int {
        notes.count
    }
    
    func notesAtIndex(at indexPath: IndexPath) -> String {
        notes[indexPath.row].title
    }
    
    func didSetupAddNoteButton() {
        view?.setupAddNoteButton()
    }
    
    func didTableViewDeselectRow(at indexPath: IndexPath) {
        view?.tableViewDeselectRow(at: indexPath)
        showNoteDetails(selectedNote: (notes[indexPath.row]))
    }
    
    func didTableViewDeleteRows(at indexPath: IndexPath) {
        removeNote(id: indexPath.row)
        notes.remove(at: indexPath.row)
        view?.tableViewDeleteRows(at: indexPath)
    }

    func userDidTapAddNoteButton() {
        router.routeToAddNotesDetail(moduleDelegate: self)
    }
    
    func loadNotes() {
        interactor.fetchNotes()
    }
    
    func showNoteDetails(selectedNote: NoteModel) {
        router.routeToUpdateNotesDetail(moduleDelegate: self,
                                        selectedNote: selectedNote)
    }
    
    func removeNote(id: Int) {
        interactor.deleteNoteFromStorage(id: id)
    }
}

extension NotesPresenter: NotesOutputInteractable {
    func notesFetched(notes: [NoteModel]) {
        self.notes = notes
        view?.reloadTableViewData()
    }
}

extension NotesPresenter: NotesDetailModuleDelegate {
    func notesUpdated(with note: NoteModel) {
        interactor.fetchNotes()
    }
    func selectedNotesUpdated(with selectedNote: NoteModel) {
        interactor.fetchNotes()
    }
}

protocol NotesPresentable {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfNote() -> Int
    func notesAtIndex(at indexPath: IndexPath) -> String
    func didSetupAddNoteButton()
    func didTableViewDeselectRow(at indexPath: IndexPath)
    func didTableViewDeleteRows(at indexPath: IndexPath)
    func userDidTapAddNoteButton()
    func loadNotes()
    func showNoteDetails(selectedNote: NoteModel)
    func removeNote(id: Int)
}
