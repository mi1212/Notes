//
//  NotesCollectionViewCell.swift
//  Notes
//
//  Created by Mikhail Chuparnov on 22.12.2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    let titleLabelView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let textLabelView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let dateLabelView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(titleLabelView)
        contentView.addSubview(textLabelView)
        contentView.addSubview(dateLabelView)
        
        let inset = 8
        
        titleLabelView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(inset)
            make.height.equalToSuperview().multipliedBy(0.4)
            make.trailing.equalTo(dateLabelView.snp.leading).inset(-inset)
        }
        textLabelView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(inset)
            make.height.equalToSuperview().multipliedBy(0.4)
            make.top.equalTo(titleLabelView.snp.bottom)
            make.trailing.equalTo(titleLabelView)
        }
        
        dateLabelView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(inset)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    
    
    func setupCellData(title: String, text: String, date: Date) {
        titleLabelView.text = title
        textLabelView.text = text
        dateLabelView.text = date.formatted(date: .numeric, time: .omitted)
    }
}
