//
//  NotesBuilder.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 18.08.2022.
//

import Foundation

enum NotesBuilder: NotesBuildable {
    static func build() -> NotesViewController {
        let view = NotesViewController()
        let presenter = NotesPresenter() //to do - constracture ile injection
        let interactor = NotesInteractor()
        let router = NotesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

protocol NotesBuildable {
    static func build() -> NotesViewController
}
