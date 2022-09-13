//
//  NotesRouter.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 12.08.2022.
//

import UIKit

// MARK: - Protocol
protocol NotesRoutable {
    func routeToAddNotesDetail(moduleDelegate: NotesDetailModuleDelegate?)
    func routeToUpdateNotesDetail(moduleDelegate: NotesDetailModuleDelegate?,
                                  selectedNote: NoteModel?)
}

// MARK: - NotesRouter
final class NotesRouter {
    weak var viewController: UIViewController?
}

// MARK: - NotesRoutable
extension NotesRouter: NotesRoutable {
    func routeToAddNotesDetail(moduleDelegate: NotesDetailModuleDelegate?) {
        viewController?.navigationController?.pushViewController(
            NotesDetailBuilder.build(
                operationType: .add,
                moduleDelegate: moduleDelegate,
                selectedNote: nil
            ),
            animated: false
        )
    }
    
    func routeToUpdateNotesDetail(moduleDelegate: NotesDetailModuleDelegate?,
                                  selectedNote: NoteModel?) {
        viewController?.navigationController?.pushViewController(
            NotesDetailBuilder.build(
                operationType: .update,
                moduleDelegate: moduleDelegate,
                selectedNote: selectedNote
            ),
            animated: false
        )
    }
}


