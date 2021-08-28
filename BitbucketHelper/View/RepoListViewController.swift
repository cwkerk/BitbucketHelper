//
//  RepoListViewController.swift
//  BitbucketHelper
//
//  Created by Chin Wee on 28/8/21.
//

import UIKit

class RepoListViewController: UIViewController {
    @IBOutlet weak var list: UITableView!
    @IBOutlet weak var nextLink: UIButton!
    @IBOutlet weak var nextLinkHeight: NSLayoutConstraint!
    
    private let cellIdentifier = "repo"
    private let segueIdentifier = "website"

    private var interactor: RepoListInteractorProtocol?
    private var selectedRepo: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.list.dataSource = self
        self.interactor = RepoListInteractor(viewController: self)
        self.interactor?.getRepoList()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.destination, segue.identifier) {
        case (let destination as RepoWebsiteViewController, self.segueIdentifier):
            guard
                let index = self.selectedRepo,
                let repo = self.interactor?.repo, repo[index].website.count > 0,
                let url = URL(string: repo[index].website)
            else {
                return
            }
            destination.webview.load(URLRequest(url: url))
        default:
            break
        }
    }

    @IBAction func showNextPage(_ sender: Any) {
        if self.interactor?.nextLink != nil {
            self.interactor?.getRepoList()
        }
    }
}

extension RepoListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor?.repo.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? RepoListTableViewCell else {
            return UITableViewCell()
        }
        if let interactor = self.interactor {
            cell.update(repo: interactor.repo[indexPath.item])
        }
        return cell
    }
}

extension RepoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let website = self.interactor?.repo[indexPath.item].website, website.count > 0 {
            self.selectedRepo = indexPath.item
            self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
}
