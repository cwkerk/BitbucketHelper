//
//  RepoListTableViewCell.swift
//  BitbucketHelper
//
//  Created by Chin Wee on 28/8/21.
//

import UIKit

class RepoListTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!

    func update(repo: Repo) {
        self.avatar.loadImage(uri: repo.owner.links.avatar.href)
        let date = self.dateFormating(value: repo.creationDate)
        self.details.text = NSLocalizedString("CREATED_AT \(date)", comment: "")
        self.name.text = repo.name
        self.type.text = repo.type
    }

    /// refactor date value to human readable value
    /// TODO: replace this function with generic helper function
    private func dateFormating(value: String) -> String {
        return value.split(separator: ".")[0].replacingOccurrences(of: "T", with: " ")
    }
}
