//
//  NotesDetailBuilder.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 18.08.2022.
//

import Foundation

enum NotesDetailBuilder: NotesDetailBuildable {
    static func build() -> NotesDetailViewController {
        let view = NotesDetailViewController()
        let presenter = NotesDetailPresenter()
        let interactor = NotesDetailInteractor()
        let router = NotesDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
