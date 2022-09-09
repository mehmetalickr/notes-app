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
    
    private let tableView = UITableView()
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
}

// MARK: - UITableViewDataSource
extension NotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfNote() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = presenter?.notesAtIndex(at: indexPath)        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTableViewDeselectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
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
        tableView.rowHeight = Style.tableViewRowHeight
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "noteCell")
        tableView.backgroundColor = Style.tableViewBackgroundColor
        self.tableView.layer.cornerRadius = Style.tableViewCornerRadius
        tableView.delegate = self
        tableView.dataSource = self
        setTableViewConstraints()

    }
    
    // MARK: - Set Table View Constraints
    func setTableViewConstraints() {
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
    
    func reloadTableViewData() {
        self.tableView.reloadData()
    }
    
    func tableViewDeselectRow(at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableViewDeleteRows(at indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

protocol NotesViewManageable: BaseViewManagable {
    func reloadTableViewData()
    func setupUI()
    func setupTableView()
    func setupAddNoteButton()
    func setTableViewConstraints()
    func tableViewDeselectRow(at indexPath: IndexPath)
    func tableViewDeleteRows(at indexPath: IndexPath)
}

