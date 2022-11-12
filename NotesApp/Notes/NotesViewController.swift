//
//  NotesViewController.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 11.08.2022.
//

import UIKit

// MARK: - BaseViewManagable
protocol NotesViewManageable: BaseViewManagable {
    var isTableViewEditing: Bool { get set }
    
    func reloadTableViewData()
    func setupTableView()
    func setupAddNoteButton()
    func setupConstraints()
    func setupTableViewHierarchy()
    func setupAddNoteButtonViewHierarchy()
    func setupEditButton()
    func hideEditButton()
    func tableViewSelectRow(at indexPath: IndexPath)
    func tableViewDeleteRows(at indexPath: IndexPath)
}

// MARK: - NotesViewController
final class NotesViewController: UIViewController {
    
    // MARK: - Variables
    var presenter: NotesPresentable!
    
    var isTableViewEditing: Bool {
        get {
            return tableView.isEditing
        }
        set {
            tableView.isEditing = newValue
        }
    }
    
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
        presenter.numberOfNotes
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
        tableView.delegate = self
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
    
    func hideEditButton() {
        navigationItem.setRightBarButton(nil, animated: true)
    }
    
    func setupTableViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupAddNoteButtonViewHierarchy() {
        view.addSubview(addNoteButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: NotesStyle.tableViewLeadingInset
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: NotesStyle.tableViewTrailingInset
            ),
            tableView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: NotesStyle.tableViewTopInset
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: NotesStyle.tableViewBottomInset
            ),
            addNoteButton.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: NotesStyle.addNoteButtonTrailingInset
            ),
            addNoteButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: NotesStyle.addNoteButtonTopInset)
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addNoteButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc
    func addNoteButtonTapped() {
        presenter.addNoteButtonTapped()
    }
    
    @objc
    func editButtonTapped(sender: UIBarButtonItem) {
        presenter.editButtonTapped()
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
    
    func tableViewSelectRow(at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableViewDeleteRows(at indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
        presenter.checkEditButtonVisibility()
    }
}
