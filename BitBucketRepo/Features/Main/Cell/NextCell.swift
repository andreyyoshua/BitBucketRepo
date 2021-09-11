//
//  NextCell.swift
//  BitBucketRepo
//
//  Created by Andrey Yoshua on 11/09/21.
//

import UIKit

class NextCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let nextLabel = UILabel()
        nextLabel.text = "Next"
        nextLabel.textColor = .blue
        nextLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nextLabel)
        
        NSLayoutConstraint.activate([
            nextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nextLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
