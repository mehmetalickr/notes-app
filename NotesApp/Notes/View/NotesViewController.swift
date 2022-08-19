//
//  NotesViewController.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 11.08.2022.
//

import SnapKit
import UIKit


class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NotesViewManageable {
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
    
    // MARK: - Setup View
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
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
        }
    }
    
    // MARK: - Configure Table View Constraints
    func configureTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(200)
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    // MARK: - Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        cell.detailTextLabel?.text = notes[indexPath.row].content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

   

