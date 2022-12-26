//
//  ViewController.swift
//  Notes
//
//  Created by Mikhail Chuparnov on 21.12.2022.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {

    var notes = [NoteEntity]()
    
    private lazy var notesTableView: UITableView = {
        let tableVIew = UITableView(frame: .zero, style: .plain)
        tableVIew.delegate = self
        tableVIew.dataSource = self
        tableVIew.backgroundColor = .clear
        tableVIew.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.identifire)
        return tableVIew
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigationBar()
        self.view.backgroundColor = .backgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchNotes()
    }

    private func setupLayout() {
        self.view.addSubview(notesTableView)
        
        notesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        let addTaskBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done , target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addTaskBarButton
    }
    
    @objc func addNote() {
        let newTaskVC = NoteViewController(isEditMode: true, note: nil)
        self.navigationController?.pushViewController(newTaskVC, animated: true)
    }
    
    private func fetchNotes() {

        let context = getContext()
        
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        
        do  {
            notes = try context.fetch(fetchRequest)
            notesTableView.reloadData()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
 
extension NotesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let context = self.getContext()
        let note = notes[indexPath.row]

        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in

            context.delete(note)

            do  {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }

            let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()

            do  {
                self.notes = try context.fetch(fetchRequest)
            } catch let error as NSError {
                print(error.localizedDescription)
            }

            tableView.deleteRows(at: [indexPath], with: .automatic)

            completionHandler(true)
        }

        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! NotesTableViewCell
        cell.selectionStyle = .none
        let note = notes[indexPath.row]
        let vc = NoteViewController(isEditMode: false, note: note)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifire) as! NotesTableViewCell
        let note = notes[indexPath.row]

        if let title = note.title, let text = note.text, let date = note.date {
            cell.setupCellData(
                title: title,
                text: text,
                date: date
            )
        }
        
        return cell
    }
    

    
}

