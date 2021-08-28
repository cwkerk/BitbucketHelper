//
//  RepoListInteractor.swift
//  BitbucketHelper
//
//  Created by Chin Wee on 28/8/21.
//

import Foundation

protocol RepoListInteractorProtocol {
    var nextLink: URL? { get }
    var presenter: RepoListPresenterProtocol { get set }
    var repo: [Repo] { get }
    func getRepoList() -> Void
}

final class RepoListInteractor: RepoListInteractorProtocol {
    internal var presenter: RepoListPresenterProtocol
    private(set) var nextLink: URL?
    private(set) var repo: [Repo] = []

    private var readyForNextPage = true

    init(viewController: RepoListViewController) {
        self.presenter = RepoListPresenter(viewController: viewController)
    }
    
    func getRepoList() {
        if !self.readyForNextPage {
            return
        }
        self.readyForNextPage = false
        let url: URL
        if let link = self.nextLink {
            url = link
        } else if let link = BITBUCKET_REPO_URL_V2 {
            url = link
        } else {
            // TODO: display warning popup
            return
        }
        NetworkRequestWorker.shared.get(type: RepoListResponse.self, url: url) { [weak self] (result) in
            if result.nextLink.count > 0 {
                self?.nextLink = URL(string: result.nextLink)
                self?.presenter.displayNextLink(hidden: false)
            } else {
                self?.presenter.displayNextLink(hidden: true)
            }
            self?.repo = result.repo
            self?.presenter.updateList(repo: result.repo)
            self?.readyForNextPage = true
        } failureHandler: { [weak self] (error) in
            self?.repo = []
            if let error = error {
                self?.presenter.display(warning: error)
            }
            self?.readyForNextPage = true
        }
    }
}
