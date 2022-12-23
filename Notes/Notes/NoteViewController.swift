//
//  NoteViewController.swift
//  Notes
//
//  Created by Mikhail Chuparnov on 23.12.2022.
//

import UIKit
import CoreData
import SnapKit

class NoteViewController: UIViewController {

    let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.placeholder = "Назовите заметку"
        textField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textField.backgroundColor = .white
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 2))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.rightView = leftView
        textField.rightViewMode = .always
        return textField
    }()
    
    let textTextField: UITextView = {
        let textField = UITextView()
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 16, weight: .light)
        textField.backgroundColor = .white
        return textField
    }()
    
    var placeholderLabel = UILabel()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.baselineAdjustment = .alignBaselines
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    convenience init(isReadingMode: Bool, note: NoteEntity?) {
        self.init()
        if isReadingMode {
            if let note = note {
                setupReadingLayout()
                setupReadingModeData(note: note)
            }
        } else {
            setupLayout()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlaceholder()
        setupNavigationBar()
        self.view.backgroundColor = .backgroundColor
    }
    
    private func setupLayout() {
        self.view.addSubview(titleTextField)
        self.view.addSubview(textTextField)
        
        let inset = 16
        
        titleTextField.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide).inset(inset)
            make.height.equalTo(48)
        }
        
        textTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(inset)
        }
    }
    
    private func setupReadingLayout() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(textLabel)
        let inset = 16
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.trailing.top.equalTo(contentView).inset(inset)
            make.height.equalTo(32)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.greaterThanOrEqualTo(28)
            make.leading.trailing.equalTo(contentView).inset(inset)
            make.bottom.equalTo(contentView)
        }
    }
    
    private func setupPlaceholder() {
        
        textTextField.delegate = self
        placeholderLabel.text = "Запишите сюда свои мысли"
        placeholderLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        placeholderLabel.sizeToFit()
        textTextField.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 8, y: (textTextField.font?.pointSize)! / 2)
        placeholderLabel.textColor = .tertiaryLabel
        placeholderLabel.isHidden = !textTextField.text.isEmpty
    }
    
    private func setupReadingModeData(note: NoteEntity) {
        if let title = note.title, let text = note.text, let date = note.date {
            titleLabel.text = title
            textLabel.text = text
        }
    }
    
    private func setupNavigationBar() {
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done , target: self, action: #selector(tapSaveButton))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func tapSaveButton() {
        if let text = textTextField.text, let title = titleTextField.text {
            let date = Date.now
            
            saveNote(title: title, text: text, date: date)
        }
    }
    
    func saveNote(title: String, text: String, date: Date) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "NoteEntity", in: context) else { return }
        
        let note = NoteEntity(entity: entity, insertInto: context)
        
        note.setValue(title, forKey: "title")
        
        note.setValue(text, forKey: "text")
        
        note.setValue(date, forKey: "date")
        
        do  {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

}

extension NoteViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
