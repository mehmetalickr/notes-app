//
//  BaseViewManagable.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 5.09.2022.
//

import UIKit

// MARK: - Protocol
protocol BaseViewManagable: BaseLayoutLoadable where Self: UIViewController {
    func setTitle(_ title: String?)
    func setBackgroundColor(_ color: UIColor)
}

// MARK: - BaseViewManagable
extension BaseViewManagable {
    func setTitle(_ title: String?) {
        self.title = title
    }
    
    func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
