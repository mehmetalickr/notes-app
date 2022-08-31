//
//  NotesRouter.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 12.08.2022.
//

import UIKit

class NotesRouter: NotesRoutable {
    weak var viewController: UIViewController!
    
    func routeToAddNotesDetail(moduleDelegate: NotesDetailModuleDelegate?) {
        viewController.navigationController?.pushViewController(
            NotesDetailBuilder.build(
                operationType: .add,
                moduleDelegate: moduleDelegate,
                selectedNote: nil
            ),
            animated: false
        )
    }
    
    func routeToUpdateNotesDetail(moduleDelegate: NotesDetailModuleDelegate?,
                                  selectedNote: NoteModel) {
        viewController.navigationController?.pushViewController(
            NotesDetailBuilder.build(
                operationType: .update,
                moduleDelegate: moduleDelegate,
                selectedNote: selectedNote
            ),
            animated: false
        )
    }
}

protocol NotesRoutable: AnyObject {
    var viewController: UIViewController! { get set }
    func routeToAddNotesDetail(moduleDelegate: NotesDetailModuleDelegate?)
    func routeToUpdateNotesDetail(moduleDelegate: NotesDetailModuleDelegate?,
                                  selectedNote: NoteModel)
}
