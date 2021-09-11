//
//  RepoCell.swift
//  BitBucketRepo
//
//  Created by Andrey Yoshua on 11/09/21.
//

import UIKit

class RepoCell: UITableViewCell {
    
    // Default View
    private let nameLabel = UILabel()
    private let typeLabel = UILabel()
    private let creationDateLabel = UILabel()
    private let avatarImageView = UIImageView()
    private let defaultBackgroundView = UIView()
    
    // Expanded View
    private let scmLabel = UILabel()
    private let languageLabel = UILabel()
    private let mainBranchLabel = UILabel()
    private let ownerNameLabel = UILabel()
    private let sizeLabel = UILabel()
    private let privateLabel = UILabel()
    private let ownerTypeLabel = UILabel()
    private let hasIssuesLabel = UILabel()
    private let goToWebsiteButton = UIButton()
    private let expandedContainerView = UIView()
    
    private var goToWebsiteHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        defaultBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(defaultBackgroundView)
        
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)

        typeLabel.numberOfLines = 0
        typeLabel.font = UIFont.systemFont(ofSize: 14)

        creationDateLabel.numberOfLines = 0
        creationDateLabel.font = UIFont.systemFont(ofSize: 12)
        creationDateLabel.textColor = UIColor.gray
        
        goToWebsiteButton.setTitle("Go To Website", for: [])
        goToWebsiteButton.setTitleColor(.blue, for: .normal)
        goToWebsiteButton.setTitleColor(.gray, for: .disabled)
        goToWebsiteButton.onTap { [weak self] in
            self?.goToWebsiteHandler?()
        }
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, typeLabel, creationDateLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setCustomSpacing(24, after: creationDateLabel)
        contentView.addSubview(stackView)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.layer.cornerRadius = 30
        avatarImageView.layer.masksToBounds = true
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.backgroundColor = .gray
        contentView.addSubview(avatarImageView)

        
        scmLabel.font = UIFont.systemFont(ofSize: 14)
        languageLabel.font = UIFont.systemFont(ofSize: 14)
        mainBranchLabel.font = UIFont.systemFont(ofSize: 14)
        ownerNameLabel.font = UIFont.systemFont(ofSize: 14)
        sizeLabel.font = UIFont.systemFont(ofSize: 14)
        privateLabel.font = UIFont.systemFont(ofSize: 14)
        ownerTypeLabel.font = UIFont.systemFont(ofSize: 14)
        hasIssuesLabel.font = UIFont.systemFont(ofSize: 14)
        let expandedStackView = UIStackView(arrangedSubviews: [scmLabel, languageLabel, mainBranchLabel, ownerNameLabel, sizeLabel, privateLabel, ownerTypeLabel, hasIssuesLabel, goToWebsiteButton])
        expandedStackView.translatesAutoresizingMaskIntoConstraints = false
        expandedStackView.axis = .vertical
        expandedStackView.spacing = 4
        
        expandedContainerView.backgroundColor = .gray.withAlphaComponent(0.1)
        expandedContainerView.translatesAutoresizingMaskIntoConstraints = false
        expandedContainerView.addSubview(expandedStackView)
        contentView.addSubview(expandedContainerView)
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: typeLabel.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            
            
            
            stackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            
            expandedContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            expandedContainerView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            expandedContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            expandedContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            expandedStackView.leadingAnchor.constraint(equalTo: expandedContainerView.leadingAnchor, constant: 16),
            expandedStackView.topAnchor.constraint(equalTo: expandedContainerView.topAnchor, constant: 8),
            expandedStackView.trailingAnchor.constraint(equalTo: expandedContainerView.trailingAnchor, constant: -16),
            expandedStackView.bottomAnchor.constraint(equalTo: expandedContainerView.bottomAnchor, constant: -8),
            
            defaultBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            defaultBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            defaultBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            defaultBackgroundView.bottomAnchor.constraint(equalTo: expandedContainerView.topAnchor),
        ])
    }
    
    @objc
    private func goToWebsite() {
        goToWebsiteHandler?()
    }
    
    func setupRepo(_ repo: Repo, expanded: Bool, goToWebsiteHandler: @escaping (() -> Void)) {
        
        nameLabel.text = repo.name
        typeLabel.text = repo.type
        let createdOn = repo.createdOn
        creationDateLabel.text = createdOn
        creationDateLabel.textAlignment = .right
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM d yyyy, h:mm a"
        
        if let date = dateFormatterGet.date(from: createdOn) {
            creationDateLabel.text = dateFormatterPrint.string(from: date)
        }
        
        if let avatarURL = URL(string: repo.owner.links.avatar.href) {
            avatarImageView.image = ImageCache.publicCache.image(url: avatarURL as NSURL)
            ImageCache.publicCache.load(url: avatarURL as NSURL, item: repo) { [weak self] repo, image in
                self?.avatarImageView.image = image
            }
        } else {
            avatarImageView.image = nil
        }
        
        
        scmLabel.text = "SCM:\t\t\t\t\(repo.scm)"
        languageLabel.text = "Language:\t\t\t\(repo.language)"
        mainBranchLabel.text = "Main Branch:\t\t\(repo.mainbranch?.name ?? "")"
        ownerNameLabel.text = "Owner Name:\t\t\(repo.owner.displayName)"
        ownerTypeLabel.text = "Owner Type:\t\t\t\(repo.owner.type)"
        sizeLabel.text = "Size:\t\t\t\t\(repo.size) bytes"
        privateLabel.text = "Is Private:\t\t\t\(repo.isPrivate ? "Yes" : "No")"
        hasIssuesLabel.text = "Has Issues:\t\t\t\(repo.isPrivate ? "Yes" : "No")"
        
        scmLabel.isHidden = !expanded
        languageLabel.isHidden = !expanded
        mainBranchLabel.isHidden = !expanded
        ownerNameLabel.isHidden = !expanded
        ownerTypeLabel.isHidden = !expanded
        sizeLabel.isHidden = !expanded
        privateLabel.isHidden = !expanded
        hasIssuesLabel.isHidden = !expanded
        goToWebsiteButton.isHidden = !expanded
        goToWebsiteButton.isEnabled = repo.website?.isEmpty == false
        expandedContainerView.isHidden = !expanded
        defaultBackgroundView.backgroundColor = expanded ? UIColor.gray.withAlphaComponent(0.4) : .white
        
        self.goToWebsiteHandler = goToWebsiteHandler
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // Configure the view for the selected state
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
