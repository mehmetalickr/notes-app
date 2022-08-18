//
//  NotesRouter.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 12.08.2022.
//

import UIKit

class NotesRouter: NotesRoutable {
    weak var viewController: UIViewController!
    
    func showNotesDetail() {
        viewController.navigationController?.pushViewController(NotesDetailBuilder.build(), animated: false)
    }

}
