//
//  NotesDetailViewController.swift
//  NotesApp
//
//  Created by Mehmet Ali ÇAKIR on 14.08.2022.
//

import SnapKit
import UIKit

// MARK: - NotesDetailViewController

final class NotesDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK: - Variables
    var presenter: NotesDetailPresentable?
    
    var titleTextField = UITextField()
    var contentTextView = UITextView()
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        presenter?.didSetupUI()
        presenter?.getNoteDetails()
    }
}

extension NotesDetailViewController {
    
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
        titleTextField.delegate = self
        self.view.addSubview(titleTextField)
        
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
        
        contentTextView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(titleTextField.snp.bottom).inset(
                Style.contentTextViewTopInset
            )
            make.bottom.equalToSuperview()
        }
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
    
    @objc
    func saveButtonTapped() {
        print("Save Note Button Tapped")
        presenter?.userDidTapSaveButton(title: titleTextField.text,
                                       content: contentTextView.text)
    }
    
    func viewNote(title: String?, content: String?) {
        titleTextField.text = title
        contentTextView.text = content
    }
}

protocol NotesDetailViewManageable: AnyObject, BaseViewManagable {
    var presenter: NotesDetailPresentable? { get set }
    func viewNote(title: String?, content: String?)
    func setupUI()
    func setupTitleTextField()
    func setupContentTextView()
    func setupSaveButton()
}
