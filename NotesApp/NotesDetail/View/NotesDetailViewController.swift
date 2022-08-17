//
//  NotesDetailViewController.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import UIKit
import SnapKit

class NoteDetailsViewController: UIViewController, UITextFieldDelegate {
    
    var titleTextField = UITextField()
    var contentTextField = UITextField()
    
    public var completion: ((String, String) -> Void)?
    
//    var presenter: NoteDetailsViewToPresenterProtocol?

    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitleTextField()
        setupContentTextField()
    
        view.backgroundColor = Style.viewBackgroundColor
//        presenter?.showNote()
    }
    
    // MARK: - Setup Title Text Field
    func setupTitleTextField() {
        titleTextField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleTextField.backgroundColor = Style.textFieldBackgroundColor
        titleTextField.borderStyle = UITextField.BorderStyle.roundedRect
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
    
    // MARK: - Configure Title Text Field Constraints
    func configureTitleTextFieldConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)

        }
    }
    
    // MARK: - Setup Content Text Field
    func setupContentTextField() {
        contentTextField.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        contentTextField.backgroundColor = Style.textFieldBackgroundColor
        contentTextField.borderStyle = UITextField.BorderStyle.none
        contentTextField.textAlignment = .left
        contentTextField.keyboardType = UIKeyboardType.default
        contentTextField.returnKeyType = UIReturnKeyType.done
        contentTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        contentTextField.delegate = self
        self.view.addSubview(contentTextField)
        configureContentTextFieldConstraints()
    }
    
    // MARK: - Configure Content Text Field Constraints
    func configureContentTextFieldConstraints() {
        contentTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(titleTextField.snp.bottom).offset(50)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textField = titleTextField.text,
            let rangeOfTextToReplace = Range(range, in: textField) else {
                return false
        }
        let substringToReplace = textField[rangeOfTextToReplace]
        let count = textField.count - substringToReplace.count + string.count
        return count <= 25
    }
    
    
//    func setupSaveButton() {
//        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
//        self.navigationItem.rightBarButtonItem  = saveButton
//    }
    
    @objc func didTapSave() {
        print("Save button tapped")
//        if let text = titleTextField.text, !text.isEmpty, contentTextField.text?.isEmpty {
//            completion?(text, contentTextField.text!)
//        }
    }
    
    
//    override func viewWillDisappear(_ animated: Bool) {
//        presenter?.editNote(content: contentTextView.text)
//    }
}

