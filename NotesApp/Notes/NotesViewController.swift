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
    func setupTableViewHierarchy()
    func setupAddNoteButtonViewHierarchy()
    func setupEditButton()
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
        let numberOfNote = presenter.numberOfNote()
        return numberOfNote
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NotesStyle.tableViewCellReuseIdentifier, for: indexPath) as? NotesTableViewCell {
            if let note = presenter.note(at: indexPath.row) {
                let cellPresenter = NotesTableViewCellPresenter(view: cell, note: note)
                cell.presenter = cellPresenter
            }
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
        let delete = UIContextualAction(style: .destructive, title: NotesStyle.tableViewDeleteActionTitle) { (action, sourceView, completionHandler) in
            self.presenter.didTableViewDeleteRows(at: indexPath)
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        return swipeActionConfig
    }
}

// MARK: - NotesViewManageable
extension NotesViewController: NotesViewManageable {
    
    // MARK: - Setup Table View
    func setupTableView() {
        tableView.rowHeight = NotesStyle.tableViewRowHeight
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesStyle.tableViewCellReuseIdentifier)
        tableView.backgroundColor = NotesStyle.tableViewBackgroundColor
        self.tableView.layer.cornerRadius = NotesStyle.tableViewCornerRadius
        tableView.dataSource = self
    }
    
    // MARK: - Setup Add Note Button
    func setupAddNoteButton() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: NotesStyle.addNoteButtonSize,
                                                      weight: .bold,
                                                      scale: .large)
        let image = UIImage(systemName: NotesStyle.addNoteButtonImage, withConfiguration: imageConfig)
        addNoteButton.tintColor = UIColor.systemYellow
        addNoteButton.setImage(image, for: .normal)
        addNoteButton.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Setup Edit Button
    func setupEditButton() {
        navigationItem.rightBarButtonItem = .init(title: NotesStyle.editButtonTitle,
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(editButtonTapped))
        navigationController?.navigationBar.tintColor = .systemYellow
    }
    
    func setupTableViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupAddNoteButtonViewHierarchy() {
        view.addSubview(addNoteButton)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(
                NotesStyle.tableViewLeadingTrailingInset
            )
            make.top.equalToSuperview().inset(
                NotesStyle.tableViewTopInset
            )
            make.bottom.equalToSuperview().inset(
                NotesStyle.tableViewBottomInset
            )
        }
        
        addNoteButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(
                NotesStyle.addNoteButtonTrailingInset
            )
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(
                NotesStyle.addNoteButtonTopInset
            )
        }
    }
    
    @objc
    func addNoteButtonTapped() {
        presenter.addNoteButtonTapped()
    }
    
    @objc
    func editButtonTapped(sender: UIBarButtonItem) {
        presenter.editButtonTapped(tableView: tableView, navigationItem: navigationItem)
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
