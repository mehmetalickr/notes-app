//
//  NotesDetailViewController.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import SnapKit
import UIKit

class NotesDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, NotesDetailViewManageable {
    var presenter: NotesDetailPresentable!
    
    var titleTextField = UITextField()
    var contentTextView = UITextView()
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Style.viewBackgroundColor
        setupUI()
        //presenter?.showNote()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //presenter?.editNote(title: titleTextField.text ?? "", content: contentTextView.text)
    }
    
    // MARK: - Setup UI
    func setupUI() {
        setupTitleTextField()
        setupContentTextView()
        setupSaveButton()
    }
    
    // MARK: - Setup Title Text Field
    func setupTitleTextField() {
        titleTextField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleTextField.backgroundColor = Style.viewBackgroundColor
        titleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = UIColor.systemYellow.cgColor
        titleTextField.layer.cornerRadius = Style.tableViewCornerRadius
        titleTextField.textAlignment = .center
        titleTextField.keyboardType = UIKeyboardType.default
        titleTextField.returnKeyType = UIReturnKeyType.done
        titleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        titleTextField.becomeFirstResponder()
        titleTextField.delegate = self
        self.view.addSubview(titleTextField)
        configureTitleTextFieldConstraints()
    }
    
    // MARK: - Setup Content Text Field
    func setupContentTextView() {
        contentTextView.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        contentTextView.isScrollEnabled = false
        contentTextView.isEditable = true
        contentTextView.center = self.view.center
        contentTextView.textAlignment = .left
        contentTextView.backgroundColor = Style.viewBackgroundColor
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
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    // MARK: - Configure Content Text View Constraints
    func configureContentTextViewConstraints() {
        contentTextView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(titleTextField.snp.bottom).inset(-20)
            make.bottom.equalToSuperview()
        }
    }
    
    func viewNotes(title: String, content: String) {
        titleTextField.text = title
        contentTextView.text = content
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

