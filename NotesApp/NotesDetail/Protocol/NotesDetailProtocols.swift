//
//  NotesDetailProtocol.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import UIKit

protocol NotesDetailModuleDelegate: AnyObject {
    func notesUpdated(with note: NoteModel)
}

protocol NotesDetailViewManageable: AnyObject {
    var presenter: NotesDetailPresentable! { get set }
    func viewNotes(title: String, content: String)
}

protocol NotesDetailPresentable: AnyObject {
    var view: NotesDetailViewManageable! { get set }
    var interactor: NotesDetailInputInteractable! { get set }
    var router: NotesDetailRoutable! { get set }
    
    func userDidTapSaveButton(title: String?, content: String?)
    //func showNote()
    //func editNote(title: String, content: String)
}

protocol NotesDetailInputInteractable: AnyObject {
    var presenter: NotesDetailOutputInteractable! { get set }
    
    func createNote(title: String?, content: String?)
    //func saveNotes(note: NoteModel)
}

protocol NotesDetailOutputInteractable: AnyObject {
    func noteUpdated(note: NoteModel)
}

protocol NotesDetailRoutable: AnyObject {
    var viewController: UIViewController! { get set }
    
    func popToMain()
}

protocol NotesDetailBuildable {
    static func build(operationType: NotesDetailOperationType,
                      moduleDelegate: NotesDetailModuleDelegate?) -> NotesDetailViewController
}
