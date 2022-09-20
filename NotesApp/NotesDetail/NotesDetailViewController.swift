//
//  NotesDetailViewController.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import SnapKit
import UIKit

// MARK: - Protocol
protocol NotesDetailViewManageable: BaseViewManagable {
    func setupTitleTextField()
    func setupContentTextView()
    func setupConstraints()
    func viewNoteTitle(title: String?)
    func viewNoteContent(content: String?)
}

// MARK: - NotesDetailViewController
final class NotesDetailViewController: UIViewController {
    
    // MARK: - Variables
    var presenter: NotesDetailPresentable!
    
    // MARK: - Private
    private let titleTextField = UITextField()
    private let contentTextView = UITextView()
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - NotesDetailViewManageable
extension NotesDetailViewController: NotesDetailViewManageable {
    
    // MARK: - Setup Title Text Field
    func setupTitleTextField() {
        titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange), for: .editingChanged)
        titleTextField.font = UIFont.systemFont(ofSize: NotesDetailStyle.titleTextFieldFontSize,
                                                weight: .bold)
        titleTextField.placeholder = NotesDetailStyle.titlePlaceholder
        titleTextField.textAlignment = .left
        titleTextField.returnKeyType = UIReturnKeyType.done
        titleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        titleTextField.delegate = self
    }
    
    // MARK: - Setup Content Text View
    func setupContentTextView() {
        contentTextView.font = UIFont.systemFont(ofSize: NotesDetailStyle.contentTextViewFontSize,
                                                 weight: .bold)
        contentTextView.isScrollEnabled = false
        contentTextView.isEditable = true
        contentTextView.center = self.view.center
        contentTextView.textAlignment = .left
        contentTextView.sizeToFit()
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.delegate = self
    }
    
    func setupViewHierarchy() {
        view.addSubview(titleTextField)
        view.addSubview(contentTextView)
    }
    
    func setupConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.height.equalTo(
                NotesDetailStyle.titleTextFieldHeight
            )
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        contentTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleTextField.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    func viewNoteTitle(title: String?) {
        titleTextField.text = title
    }
    
    func viewNoteContent(content: String?) {
        contentTextView.text = content
    }
}

// MARK: - Events
extension NotesDetailViewController {
    @objc
    private func titleTextFieldDidChange() {
        presenter.userDidSaveNote(title: titleTextField.text,
                                  content: contentTextView.text)
    }
}

extension NotesDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        presenter.didSetTitleTextFieldsCharacterLimit(textField: titleTextField,
                                                      shouldChangeCharactersIn: range,
                                                      replacementString: string)
    }
}

// MARK: - Setup Content Text View
extension NotesDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        presenter.userDidSaveNote(title: titleTextField.text,
                                  content: contentTextView.text)
    }
}
