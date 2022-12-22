//
//  NotesCollectionViewCell.swift
//  Notes
//
//  Created by Mikhail Chuparnov on 22.12.2022.
//

import UIKit

class NotesCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .appColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
