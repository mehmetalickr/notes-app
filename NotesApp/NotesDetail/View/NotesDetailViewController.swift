//
//  NotesDetailViewController.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import SnapKit
import UIKit

class NotesDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var presenter: NotesDetailPresentable!
    
    var titleTextField = UITextField()
    var contentTextView = UITextView()
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Style.viewBackgroundColor
        setupUI()
        presenter?.getNoteDetails()
    }
    
    // MARK: - Setup UI
    func setupUI() {
        setupTitleTextField()
        setupContentTextView()
        setupSaveButton()
    }
    
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
        titleTextField.keyboardType = UIKeyboardType.default
        titleTextField.returnKeyType = UIReturnKeyType.done
        titleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        titleTextField.becomeFirstResponder()
        titleTextField.delegate = self
        self.view.addSubview(titleTextField)
        configureTitleTextFieldConstraints()
    }
    
    // MARK: - Setup Content Text View
    func setupContentTextView() {
        contentTextView.font = UIFont.systemFont(ofSize: Style.contentTextViewFontSize,
                                                 weight: .bold)
        contentTextView.isScrollEnabled = false
        contentTextView.isEditable = true
        contentTextView.center = self.view.center
        contentTextView.textAlignment = .left
        contentTextView.backgroundColor = Style.contentTextViewBackgroundColor
        contentTextView.sizeToFit()
        contentTextView.translatesAutoresizingMaskIntoConstraints = true
        contentTextView.delegate = self
        self.view.addSubview(contentTextView)
        configureContentTextViewConstraints()
    }
    
    // MARK: - Setup Save Button
    func setupSaveButton() -> UINavigationItem {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(saveButtonTapped))
        self.navigationController?.navigationBar.tintColor = UIColor.systemYellow
        return navigationItem
    }
    
    // MARK: - Configure Title Text Field Constraints
    func configureTitleTextFieldConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.height.equalTo(
                Style.titleTextFieldHeight
            )
            make.leading.trailing.equalToSuperview().inset(
                Style.titleTextFieldLeadingTrailingInset
            )
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    // MARK: - Configure Content Text View Constraints
    func configureContentTextViewConstraints() {
        contentTextView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(titleTextField.snp.bottom).inset(
                Style.contentTextViewTopInset
            )
            make.bottom.equalToSuperview()
        }
    }
    
    // This function setting title text field's maximum character count.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textField = titleTextField.text,
              let rangeOfTextToReplace = Range(range, in: textField) else {
            return false
        }
        let substringToReplace = textField[rangeOfTextToReplace]
        let count = textField.count - substringToReplace.count + string.count
        return count <= TextLimit.maxCharacter
    }
}

extension NotesDetailViewController {
    
    @objc
    func saveButtonTapped() {
        print("Save Note Button Tapped")
        presenter.userDidTapSaveButton(title: titleTextField.text,
                                       content: contentTextView.text)
    }
}

extension NotesDetailViewController: NotesDetailViewManageable {
    func viewNote(title: String?, content: String?) {
        titleTextField.text = title
        contentTextView.text = content
    }
}

protocol NotesDetailViewManageable: AnyObject {
    var presenter: NotesDetailPresentable! { get set }
    func viewNote(title: String?, content: String?)
}
