//
//  NotesBuilder.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 18.08.2022.
//

import Foundation

// MARK: - NotesBuilder
final class NotesBuilder {
    static func build() -> NotesViewController {
        let view = NotesViewController()
        let router = NotesRouter()
        let interactor = NotesInteractor()
        let presenter = NotesPresenter(view: view,
                                       interactor: interactor,
                                       router: router)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}
