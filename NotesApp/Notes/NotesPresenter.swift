//
//  NotesPresenter.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 11.08.2022.
//

import Foundation
import UIKit

// MARK: - Protocol
protocol NotesPresentable {
    func viewDidLoad()
    func numberOfNote() -> Int
    func note(at index: Int) -> NoteModel?
    func didSetupAddNoteButton()
    func didTableViewSelectRow(at indexPath: IndexPath)
    func didTableViewDeleteRows(at indexPath: IndexPath)
    func addNoteButtonTapped()
    func editButtonTapped(tableView: UITableView, navigationItem: UINavigationItem)
    func showNoteDetails(selectedNote: NoteModel)
    func removeNote(id: Int)
}

// MARK: - NotesPresentable
final class NotesPresenter: NotesPresentable {
    
    // MARK: - View & Interactor & Router
    weak var view: NotesViewManageable?
    private let interactor: NotesInputInteractable
    private let router: NotesRoutable
    
    private var notes: [NoteModel]?
    
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
        view?.setupTableViewHierarchy()
        view?.setupAddNoteButtonViewHierarchy()
        view?.setupConstraints()
        view?.setTitle(Style.title)
        view?.setBackgroundColor(Style.viewBackgroundColor)
        view?.setupTableView()
        view?.setupAddNoteButton()
        view?.setupEditButton()
        interactor.fetchNotes()
    }
    
    func numberOfNote() -> Int {
        notes?.count ?? .zero
    }
    
    func note(at index: Int) -> NoteModel? {
        notes?[index]
    }
    
    func didSetupAddNoteButton() {
        view?.setupAddNoteButton()
    }
    
    func didTableViewSelectRow(at indexPath: IndexPath) {
        view?.tableViewSelectRow(at: indexPath)
        guard let selectedNote = notes?[indexPath.row] else { return }
        showNoteDetails(selectedNote: selectedNote)
    }
    
    func didTableViewDeleteRows(at indexPath: IndexPath) {
        removeNote(id: indexPath.row)
        notes?.remove(at: indexPath.row)
        view?.tableViewDeleteRows(at: indexPath)
    }
    
    func addNoteButtonTapped() {
        router.routeToAddNotesDetail(moduleDelegate: self)
    }
    
    func editButtonTapped(tableView: UITableView, navigationItem: UINavigationItem) {
        if(tableView.isEditing == true)
        {
            navigationItem.rightBarButtonItem?.title = NotesStyle.editButtonTitle
            tableView.isEditing = false
        }
        else
        {
            tableView.isEditing = true
            navigationItem.rightBarButtonItem?.title = NotesStyle.doneButtonTitle
        }
    }
    
    func showNoteDetails(selectedNote: NoteModel) {
        router.routeToUpdateNotesDetail(moduleDelegate: self,
                                        selectedNote: selectedNote)
    }
    
    func removeNote(id: Int) {
        interactor.deleteNoteFromStorage(id: id)
    }
}

// MARK: - NotesOutputInteractable
extension NotesPresenter: NotesOutputInteractable {
    func notesFetched(notes: [NoteModel]) {
        self.notes = notes
        view?.reloadTableViewData()
    }
}

// MARK: - NotesDetailModuleDelegate
extension NotesPresenter: NotesDetailModuleDelegate {
    func notesUpdated(with note: NoteModel) {
        interactor.fetchNotes()
    }
}
