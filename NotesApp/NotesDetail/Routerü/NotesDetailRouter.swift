//
//  NotesDetailRouter.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import UIKit

class NotesDetailRouter: NotesDetailRoutable {
    var viewController: UIViewController!
    
    func popToMain() {
        viewController.navigationController?.popViewController(animated: false)
    }
}
