//
//  RepoListPresenter.swift
//  BitbucketHelper
//
//  Created by Chin Wee on 28/8/21.
//

import UIKit

protocol RepoListPresenterProtocol: class {
    var viewController: RepoListViewController { get }
    func displayNextLink(hidden: Bool) -> Void
    func display(warning: Error) -> Void
    func updateList(repo: [Repo]) -> Void
}

final class RepoListPresenter: RepoListPresenterProtocol {
    unowned let viewController: RepoListViewController

    init(viewController: RepoListViewController) {
        self.viewController = viewController
    }

    func displayNextLink(hidden: Bool) {
        self.viewController.nextLink.isHidden = hidden
        if hidden {
            self.viewController.nextLinkHeight.constant = 0
        } else {
            self.viewController.nextLinkHeight.constant = 50
        }
    }

    func display(warning: Error) {
        let alert = UIAlertController(
            title: NSLocalizedString("GENERIC_POPUP_TITLE", comment: ""),
            message: warning.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("GENERIC_POPUP_OK_BUTTON", comment: ""),
            style: .default,
            handler: nil
        ))
        self.viewController.present(alert, animated: true, completion: nil)
    }

    func updateList(repo: [Repo]) {
        self.viewController.list.reloadData()
    }
}
