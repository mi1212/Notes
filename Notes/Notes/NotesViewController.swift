//
//  ViewController.swift
//  Notes
//
//  Created by Mikhail Chuparnov on 21.12.2022.
//

import UIKit

class NotesViewController: UIViewController {

    private lazy var notesCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .yellow
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(NotesCollectionViewCell.self, forCellWithReuseIdentifier: NotesCollectionViewCell.identifire)
        return collection
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
 
extension NotesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 16
        let width = Int(self.view.bounds.width)
        let height = (Int(self.view.bounds.height) - inset*7)/6
        return CGSize(width: width, height: height)
    }
}

extension NotesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCollectionViewCell.identifire, for: indexPath)
        return cell
    }
    
    
}

