//
//  NotesCollectionViewCell.swift
//  Notes
//
//  Created by Mikhail Chuparnov on 22.12.2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .appColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
