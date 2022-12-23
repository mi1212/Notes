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

    let titleView: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.backgroundColor = .white
        return textField
    }()
    
    let textView: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.backgroundColor = .white
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigationBar()
        self.view.backgroundColor = .backgroundColor
        // Do any additional setup after loading the view.
    }
    
    private func setupLayout() {
        self.view.addSubview(titleView)
        self.view.addSubview(textView)
        
        let inset = 16
        
        titleView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide).inset(inset)
            make.height.equalTo(64)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).inset(-inset)
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(inset)
        }
    }
    
    private func setupNavigationBar() {
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done , target: self, action: #selector(tapSaveButton))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func tapSaveButton() {
        if let text = textView.text, let title = titleView.text {
            let date = Date.now
            
            saveNote(title: title, text: text, date: date)
        }
    }
    
    func saveNote(title: String, text: String, date: Date) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext) else { return }
     
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        
        note.setValue(title, forKey: "title")
        
        note.setValue(text, forKey: "text")
        
        note.setValue(date, forKey: "date")
        
        do  {
            try managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

}
