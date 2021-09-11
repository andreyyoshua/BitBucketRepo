//
//  MainViewController.swift
//  BitBucketRepo
//
//  Created by Andrey Yoshua on 11/09/21.
//

import Combine
import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // UI
    private let tableView = UITableView()
    
    // DATA
    private let viewModel: MainViewModel
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: MainViewModel = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        
        viewModel.$rows
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &bindings)
        
        viewModel.fetchBitBucketResponse()
    }
    
    fileprivate func setupTableView() {
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.description())
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.description())
        tableView.register(NextCell.self, forCellReuseIdentifier: NextCell.description())
        tableView.register(ErrorCell.self, forCellReuseIdentifier: ErrorCell.description())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if case let .repo(repo, expanded) = viewModel.rows[indexPath.row],
           let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.description(), for: indexPath) as? RepoCell {
            cell.setupRepo(repo, expanded: expanded, goToWebsiteHandler: { [weak self] () in
                guard let webSite = repo.website, let url = URL(string: webSite) else { return }
                self?.present(WebViewController(request: URLRequest(url: url), title: repo.name), animated: true, completion: nil)
            })
            return cell
        }
        
        if case .loading = viewModel.rows[indexPath.row],
           let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.description(), for: indexPath) as? LoadingCell {
            cell.indicatorView.startAnimating()
            return cell
        }
        
        if case .next = viewModel.rows[indexPath.row],
           let cell = tableView.dequeueReusableCell(withIdentifier: NextCell.description(), for: indexPath) as? NextCell {
            return cell
        }
        
        if case let .error(error) = viewModel.rows[indexPath.row],
           let cell = tableView.dequeueReusableCell(withIdentifier: ErrorCell.description(), for: indexPath) as? ErrorCell {
            cell.setupError(error)
            return cell
        }
        
        return UITableViewCell()
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectRow(at: indexPath)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

