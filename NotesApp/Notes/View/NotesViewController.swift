//
//  NotesViewController.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 11.08.2022.
//

import SnapKit
import UIKit


class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView = UITableView()
    
    private var notes: [NoteModel] = []
    var presenter: ViewToPresenterProtocol?

    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        setupTableView()
        setupAddNoteButton()
        view.backgroundColor = Style.viewBackgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.loadNotes()
    }
    
    // MARK: - Setup View
    func setupTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = Style.tableViewRowHeight
        //register cells
        configureTableViewConstraints()
        tableView.backgroundColor = Style.tableViewBackgroundColor
        self.tableView.layer.cornerRadius = Style.tableViewCornerRadius
    }
    
    func setupAddNoteButton() {
        let button = UIButton()
        self.view.addSubview(button)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let image = UIImage(systemName: "note.text.badge.plus", withConfiguration: imageConfig)
        button.tintColor = UIColor.systemYellow
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
        
        button.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
        }
    }
    
    // MARK: - Table View Delegate
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Configure Constraints
    func configureTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(200)
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    @objc func addNoteButtonTapped(sender: UIButton) {
//            presenter?.addNote()
        self.navigationController?.pushViewController(NoteDetailsViewController(), animated: false)
        }
    
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
