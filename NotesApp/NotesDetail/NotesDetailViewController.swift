//
//  NotesDetailViewController.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import UIKit

// MARK: - Protocol
protocol NotesDetailViewManageable: BaseViewManagable {
    func setupTitleTextField()
    func setupContentTextView()
    func setupTitleTextFieldViewHierarchy()
    func setupContentTextViewHierarchy()
    func setupConstraints()
    func setTitleTextFieldText(with text: String?)
    func setContentTextViewText(with text: String?)
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
    
    func setupTitleTextFieldViewHierarchy() {
        view.addSubview(titleTextField)
    }
    
    func setupContentTextViewHierarchy() {
        view.addSubview(contentTextView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(
                equalToConstant: NotesDetailStyle.titleTextFieldHeight
            ),
            titleTextField.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            titleTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            titleTextField.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            contentTextView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            contentTextView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            contentTextView.topAnchor.constraint(
                equalTo: titleTextField.bottomAnchor
            ),
            contentTextView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor)
        ])
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setTitleTextFieldText(with text: String?) {
        titleTextField.text = text
    }
    
    func setContentTextViewText(with text: String?) {
        contentTextView.text = text
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
