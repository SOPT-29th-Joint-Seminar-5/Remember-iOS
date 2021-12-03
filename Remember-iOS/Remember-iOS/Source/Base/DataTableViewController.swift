//
//  DataTableViewController.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/16.
//

import UIKit

class DataTableViewController: UITableViewController {
    
    // MARK: - Section
    
    enum Section: Int, CaseIterable {
        case content
        case comment
    }
    
    // MARK: - Properties
    
    public var id: Int?
    
    // MARK: - Manager
    
    private let manager = PostManager.shared
    
    // MARK: - Initializers

    required init?(coder: NSCoder) {
        super.init(style: .grouped)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        connectServer()
    }
    
    // MARK: - Setup Methods
    
    private func setupTableView() {
        ContentTVC.register(target: tableView)
        CommentTVC.register(target: tableView)
        
        setupStatusBar(.white)
        tableView.backgroundColor = .white
        tableView.contentInset = UIEdgeInsets(top: 48, left: 0, bottom: 132, right: 0)
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
    private func connectServer() {
        guard let id = id else { return }
        manager.fetchPost(id: id) { [weak self] data, error in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section.init(rawValue: section) else { return 0 }
        
        switch section {
        case .content: return 1
        case .comment:
            let commentCnt = manager.views < 3 ? manager.views : 3
            return commentCnt
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section.init(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .content:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTVC.className, for: indexPath) as? ContentTVC else { return UITableViewCell() }
            cell.setupData()
            return cell
        case .comment:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTVC.className, for: indexPath) as? CommentTVC else { return UITableViewCell() }
            cell.setupData(nickname: manager.contents[0].comment[0].nickname, content: manager.contents[0].comment[0].content)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Section.init(rawValue: indexPath.section) else { return 0 }
        
        switch section {
        case .content:
            return 408
        case .comment:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = Section.init(rawValue: section) else { return 0 }
        
        switch section {
        case .content:
            return 0
        case .comment:
            return 48
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = Section.init(rawValue: section) else { return UIView() }
        
        switch section {
        case .content:
            return UIView()
        case .comment:
            return CommentHeader(count: manager.views)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
