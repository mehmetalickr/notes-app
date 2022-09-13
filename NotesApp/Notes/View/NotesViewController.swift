//
//  NotesViewController.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 11.08.2022.
//

import SnapKit
import UIKit

// MARK: - BaseViewManagable
protocol NotesViewManageable: BaseViewManagable {
    func reloadTableViewData()
    func setupTableView()
    func setupAddNoteButton()
    func tableViewSelectRow(at indexPath: IndexPath)
    func tableViewDeleteRows(at indexPath: IndexPath)
}

// MARK: - NotesViewController
final class NotesViewController: UIViewController {
    
    // MARK: - Variables
    var presenter: NotesPresentable!
    
    private let tableView = UITableView()
    private let addNoteButton = UIButton()
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource
extension NotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfNote()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Style.tableViewCellReuseIdentifier, for: indexPath) as? NotesTableViewCell {
            cell.textLabel?.text = presenter.notesAtIndex(at: indexPath)
            return cell
        }
        fatalError("Could not dequeueReusableCell")
    }
}

// MARK: - UITableViewDelegate
extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTableViewSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: Style.tableViewDeleteActionTitle) { (action, sourceView, completionHandler) in
            self.presenter.didTableViewDeleteRows(at: indexPath)
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        return swipeActionConfig
    }
}

// MARK: - NotesViewManageable
extension NotesViewController: NotesViewManageable {
    
    func setupViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(addNoteButton)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(
                Style.tableViewLeadingTrailingInset
            )
            make.top.equalToSuperview().inset(
                Style.tableViewTopInset
            )
            make.bottom.equalToSuperview().inset(
                Style.tableViewBottomInset
            )
        }
        
        addNoteButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(
                Style.addNoteButtonTrailingInset
            )
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(
                Style.addNoteButtonTopInset
            )
        }
    }
    
    // MARK: - Setup Table View
    func setupTableView() {
        tableView.rowHeight = Style.tableViewRowHeight
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: Style.tableViewCellReuseIdentifier)
        tableView.backgroundColor = Style.tableViewBackgroundColor
        self.tableView.layer.cornerRadius = Style.tableViewCornerRadius
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Setup Add Note Button
    func setupAddNoteButton() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: Style.addNoteButtonSize,
                                                      weight: .bold,
                                                      scale: .large)
        let image = UIImage(systemName: Style.addNoteButtonImage, withConfiguration: imageConfig)
        addNoteButton.tintColor = UIColor.systemYellow
        addNoteButton.setImage(image, for: .normal)
        addNoteButton.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func addNoteButtonTapped() {
        presenter.addNoteButtonTapped()
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
    
    func tableViewSelectRow(at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableViewDeleteRows(at indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
