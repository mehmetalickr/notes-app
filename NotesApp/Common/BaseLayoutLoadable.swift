//
//  BaseLayoutLoadable.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 9.09.2022.
//

import UIKit

// MARK: - Protocol
protocol BaseLayoutLoadable {
    func setupConstraints()
    func setupViewDelegate()
}

// MARK: - BaseLayoutLoadable
extension BaseLayoutLoadable {
    
    func setupConstraints() {
        // With this func we will setup the views constraints on view controller.
    }
    
    func setupViewDelegate() {
        // With this func we will setup the views delegates on view contoller.
    }
}
