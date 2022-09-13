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
    func setupSaveButton()
    func viewNoteTitle(title: String?)
    func viewNoteContent(content: String?)
}

// MARK: - NotesDetailViewController
final class NotesDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK: - Variables
    var presenter: NotesDetailPresentable!
    
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
        titleTextField.font = UIFont.systemFont(ofSize: Style.titleTextFieldFontSize,
                                                weight: .bold)
        titleTextField.backgroundColor = Style.titleTextFieldBackgroundColor
        titleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        titleTextField.layer.borderWidth = Style.titleTextFieldBorderWidth
        titleTextField.layer.borderColor = UIColor.systemYellow.cgColor
        titleTextField.layer.cornerRadius = Style.titleTextFieldCornerRadius
        titleTextField.textAlignment = .center
        titleTextField.returnKeyType = UIReturnKeyType.done
        titleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
    }
    
    // MARK: - Setup Content Text View
    func setupContentTextView() {
        contentTextView.font = UIFont.systemFont(ofSize: Style.contentTextViewFontSize,
                                                 weight: .bold)
        contentTextView.backgroundColor = Style.contentTextViewBackgroundColor
        contentTextView.isScrollEnabled = false
        contentTextView.isEditable = true
        contentTextView.center = self.view.center
        contentTextView.textAlignment = .left
        contentTextView.sizeToFit()
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Setup Save Button
    func setupSaveButton() {
        navigationItem.rightBarButtonItem = .init(title: Style.buttonTitle,
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(saveButtonTapped))
        navigationController?.navigationBar.tintColor = .systemYellow
    }
    
    func viewNoteTitle(title: String?) {
        titleTextField.text = title
    }
    
    func viewNoteContent(content: String?) {
        contentTextView.text = content
    }
}

extension NotesDetailViewController {
    func setupViewDelegate() {
        titleTextField.delegate = self
        contentTextView.delegate = self
    }
    
    func setupViewHierarchy() {
        view.addSubview(titleTextField)
        view.addSubview(contentTextView)
    }
    
    func setupConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.height.equalTo(
                Style.titleTextFieldHeight
            )
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(
                Style.contentTextFieldLeadingTrailingInset
            )
        }
        contentTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(
                Style.contentTextFieldLeadingTrailingInset
            )
            make.top.equalTo(titleTextField.snp.bottom).inset(
                Style.contentTextViewTopInset
            )
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Private
private extension NotesDetailViewController {
    @objc
    func saveButtonTapped() {
        presenter.userDidTapSaveButton(title: titleTextField.text,
                                        content: contentTextView.text)
    }
}
