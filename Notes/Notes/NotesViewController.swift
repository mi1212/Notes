//
//  ViewController.swift
//  Notes
//
//  Created by Mikhail Chuparnov on 21.12.2022.
//

import UIKit

class NotesViewController: UIViewController {

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
        self.view.backgroundColor = .backgroundColor
        
    }

    private func setupLayout() {
        self.view.addSubview(notesCollectionView)
        
        notesCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
}
 
extension NotesViewController: UITableViewDelegate {

}

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifire) as! NotesTableViewCell
        return cell
    }
    

    
}

