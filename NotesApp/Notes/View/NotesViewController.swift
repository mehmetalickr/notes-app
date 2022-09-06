//
//  NotesViewController.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 11.08.2022.
//

import SnapKit
import UIKit

// MARK: - NotesViewController

final class NotesViewController: UIViewController, NotesViewManageable {
    
    // MARK: - Variables
    var presenter: NotesPresentable?
    
    var tableView = UITableView()
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        presenter?.didSetupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
        presenter?.loadNotes()
    }
}

// MARK: - UITableViewDataSource
extension NotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.notes.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = presenter?.notes[indexPath.row].title
        cell.detailTextLabel?.text = presenter?.notes[indexPath.row].content
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTableViewDeselectRow(at: indexPath)
        presenter?.showNoteDetails(selectedNote: (presenter?.notes[indexPath.row])!)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.presenter?.removeNote(id: indexPath.row)
            self.presenter?.notes.remove(at: indexPath.row)
            self.presenter?.didTableViewDeleteRows(at: indexPath)
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        return swipeActionConfig
    }
}

extension NotesViewController {
    
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
    
    // MARK: - Table View Delegates
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
    
    @objc
    func addNoteButtonTapped() {
        presenter?.userDidTapAddNoteButton()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
        
    func tableViewDeselectRow(at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableViewDeleteRows(at indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

protocol NotesViewManageable: AnyObject, BaseViewManagable {
    var presenter: NotesPresentable? { get set }
    func reloadTableView()
    func setupUI()
    func setupTableView()
    func setTableViewDelegates()
    func setupAddNoteButton()
    func tableViewDeselectRow(at indexPath: IndexPath)
    func tableViewDeleteRows(at indexPath: IndexPath)
}

