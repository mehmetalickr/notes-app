//
//  NotesDetailBuilder.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 18.08.2022.
//

import Foundation

// MARK: - NotesDetailBuilder
final class NotesDetailBuilder {
    static func build(operationType: NotesDetailOperationType,
                      moduleDelegate: NotesDetailModuleDelegate?,
                      selectedNote: NoteModel?) -> NotesDetailViewController {
        let view = NotesDetailViewController()
        let interactor = NotesDetailInteractor()
        let presenter = NotesDetailPresenter(view: view,
                                             interactor: interactor,
                                             operationType: operationType,
                                             moduleDelegate: moduleDelegate,
                                             selectedNote: selectedNote)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}
