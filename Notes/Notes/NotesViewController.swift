//
//  ViewController.swift
//  Notes
//
//  Created by Mikhail Chuparnov on 21.12.2022.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {

    var notes = [NSManagedObject]()
    
    private lazy var notesCollectionView: UITableView = {
        let tableVIew = UITableView(frame: .zero, style: .plain)
        tableVIew.delegate = self
        tableVIew.dataSource = self
        tableVIew.backgroundColor = .yellow
        tableVIew.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.identifire)
        return tableVIew
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigationBar()
        fetchNotes()
        self.view.backgroundColor = .backgroundColor
        
    }

    private func setupLayout() {
        self.view.addSubview(notesCollectionView)
        
        notesCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setupNavigationBar() {
        let addTaskBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done , target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addTaskBarButton
    }
    
    @objc func addNote() {
        let newTaskVC = NoteViewController()
        self.navigationController?.pushViewController(newTaskVC, animated: true)
    }
    
    private func fetchNotes() {
        let managedContext = getContext()
        
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSManagedObject.fetchRequest()
        
        var error: NSError?
         
        do  {
            let fetchedResults =
            try managedContext.execute(fetchRequest) as? [NSManagedObject]
            
            if let result = fetchedResults {
                notes = result
            }
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

}

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifire) as! NotesTableViewCell
        let note = notes[indexPath.row]
        
        return cell
    }
    

    
}

