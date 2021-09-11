//
//  Entities.swift
//  BitBucketRepo
//
//  Created by Andrey Yoshua on 11/09/21.
//

import Foundation

// MARK: - BitbucketResponse
struct BitbucketResponse: Decodable {
    let pageLength: Int
    let repos: [Repo]
    let next: String
    
    enum CodingKeys: String, CodingKey {
        case pageLength = "pagelen"
        case repos = "values"
        case next
    }
}

// MARK: - Value
struct Repo: Decodable, Equatable {
    let scm: String
    let website: String?
    let hasWiki: Bool
    let uuid: String
    let links: ValueLinks
    let forkPolicy: String
    let fullName, name: String
    let project: Project
    let language, createdOn: String
    let mainbranch: Mainbranch?
    let workspace: Project
    let hasIssues: Bool
    let owner: Owner
    let updatedOn: String
    let size: Int
    let type: String
    let slug: String
    let isPrivate: Bool
    let valueDescription: String

    enum CodingKeys: String, CodingKey {
        case scm, website
        case hasWiki = "has_wiki"
        case uuid, links
        case forkPolicy = "fork_policy"
        case fullName = "full_name"
        case name, project, language
        case createdOn = "created_on"
        case mainbranch, workspace
        case hasIssues = "has_issues"
        case owner
        case updatedOn = "updated_on"
        case size, type, slug
        case isPrivate = "is_private"
        case valueDescription = "description"
    }
}

// MARK: - ValueLinks
struct ValueLinks: Decodable, Equatable {
    let watchers, branches, tags, commits: Avatar
    let clone: [Clone]
    let linksSelf, source, html, avatar: Avatar
    let hooks, forks, downloads, pullrequests: Avatar
    let issues: Avatar?

    enum CodingKeys: String, CodingKey {
        case watchers, branches, tags, commits, clone
        case linksSelf = "self"
        case source, html, avatar, hooks, forks, downloads, pullrequests, issues
    }
}

// MARK: - Avatar
struct Avatar: Decodable, Equatable {
    let href: String
}

// MARK: - Clone
struct Clone: Decodable, Equatable {
    let href: String
    let name: String
}

// MARK: - Mainbranch
struct Mainbranch: Decodable, Equatable {
    let type: String
    let name: String
}

// MARK: - Owner
struct Owner: Decodable, Equatable {
    let displayName, uuid: String
    let links: OwnerLinks
    let type: String
    let nickname: String?
    let accountID: String?
    let username: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case uuid, links, type, nickname
        case accountID = "account_id"
        case username
    }
}

// MARK: - OwnerLinks
struct OwnerLinks: Decodable, Equatable {
    let linksSelf, html, avatar: Avatar

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, avatar
    }
}
// MARK: - Project
struct Project: Decodable, Equatable {
    let links: OwnerLinks
    let type: String
    let name: String
    let key: String?
    let uuid: String
    let slug: String?
}
