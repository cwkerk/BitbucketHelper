//
//  Repo.swift
//  BitbucketHelper
//
//  Created by Chin Wee on 28/8/21.
//

import Foundation

struct RepoOwnerAvatar: Codable {
    private(set) var href: String

    enum CodingKeys: String, CodingKey {
        case href = "href"
    }
}

struct RepoOwnerLinks: Codable {
    private(set) var avatar: RepoOwnerAvatar

    enum CodingKeys: String, CodingKey {
        case avatar = "avatar"
    }
}

struct RepoOwner: Codable {
    private(set) var links: RepoOwnerLinks
    enum CodingKeys: String, CodingKey {
        case links = "links"
    }
}

struct Repo: Codable {
    private(set) var creationDate: String
    private(set) var name: String
    private(set) var owner: RepoOwner
    private(set) var type: String
    private(set) var website: String

    enum CodingKeys: String, CodingKey {
        case creationDate = "created_on"
        case name = "name"
        case owner = "owner"
        case type = "type"
        case website = "website"
    }
}

struct RepoListResponse: Codable {
    private(set) var nextLink: String
    private(set) var pageCount: Int
    private(set) var repo: [Repo]
    
    enum CodingKeys: String, CodingKey {
        case nextLink = "next"
        case pageCount = "pagelen"
        case repo = "values"
    }
}
