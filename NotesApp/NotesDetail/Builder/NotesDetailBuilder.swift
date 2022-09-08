//
//  NotesDetailBuilder.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 18.08.2022.
//

import Foundation

final class NotesDetailBuilder: NotesDetailBuildable {
    static func build(operationType: NotesDetailOperationType,
                      moduleDelegate: NotesDetailModuleDelegate?,
                      selectedNote: NoteModel?) -> NotesDetailViewController {
        let view = NotesDetailViewController()
        let interactor = NotesDetailInteractor()
        let router = NotesDetailRouter()
        let presenter = NotesDetailPresenter(view: view,
                                             interactor: interactor,
                                             router: router,
                                             operationType: operationType,
                                             moduleDelegate: moduleDelegate,
                                             selectedNote: selectedNote)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

protocol NotesDetailBuildable {
    static func build(operationType: NotesDetailOperationType,
                      moduleDelegate: NotesDetailModuleDelegate?,
                      selectedNote: NoteModel?) -> NotesDetailViewController
}
