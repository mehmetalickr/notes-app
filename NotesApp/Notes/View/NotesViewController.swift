//
//  NotesViewController.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 11.08.2022.
//

import SnapKit
import UIKit


class NotesViewController: UIViewController, NotesViewManageable {
    var presenter: NotesPresentable!
    
    var tableView = UITableView()
    private var notes: [NoteModel] = []
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        setupUI()
        view.backgroundColor = Style.viewBackgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.loadNotes()
    }
    
    // MARK: - Setup UI
    func setupUI() {
        setupTableView()
        setupAddNoteButton()
    }
    
    // MARK: - Setup Table View
    func setupTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = Style.tableViewRowHeight
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "noteCell")
        tableView.backgroundColor = Style.tableViewBackgroundColor
        self.tableView.layer.cornerRadius = Style.tableViewCornerRadius
        tableView.delegate = self
        tableView.dataSource = self
        configureTableViewConstraints()
    }
    
    // MARK: - Table View Delegate
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Setup Add Note Button
    func setupAddNoteButton() {
        let button = UIButton()
        self.view.addSubview(button)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: Style.addNoteButtonSize,
                                                      weight: .bold,
                                                      scale: .large)
        let image = UIImage(systemName: "note.text.badge.plus", withConfiguration: imageConfig)
        button.tintColor = UIColor.systemYellow
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
        
        button.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(
                Style.addNoteButtonTrailingInset
            )
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(
                Style.addNoteButtonTopInset
            )
        }
    }
    
    // MARK: - Configure Table View Constraints
    func configureTableViewConstraints() {
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
    }
}

// MARK: - UITable View Data Source
extension NotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        cell.detailTextLabel?.text = notes[indexPath.row].content
        
        return cell
    }
}

// MARK: - UITable View Delegate
extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.showNoteDetails(selectedNote: notes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.presenter.removeNote(id: indexPath.row)
            self.notes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        return swipeActionConfig
    }
}
extension NotesViewController {
    
    @objc
    func addNoteButtonTapped() {
        presenter.userDidTapAddNoteButton()
    }
    
    func viewNotes(notes: [NoteModel]) {
        self.notes = notes
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

protocol NotesViewManageable: AnyObject {
    var presenter: NotesPresentable! { get set }
    func viewNotes(notes: [NoteModel])
}



