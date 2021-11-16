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
    
    // MARK: - Private Properties
    
    private var commentLists: [String] = [""]
    
    // MARK: - Initializers

    required init?(coder: NSCoder) {
        super.init(style: .grouped)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Setup Methods
    
    private func setupTableView() {
        setupStatusBar(.white)
        tableView.backgroundColor = .white
        ContentTVC.register(target: tableView)
        CommentTVC.register(target: tableView)
        
        tableView.contentInset = UIEdgeInsets(top: 48, left: 0, bottom: 0, right: 0)
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
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
        case .comment: return commentLists.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section.init(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .content:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTVC.className, for: indexPath) as? ContentTVC else { return UITableViewCell() }
            return cell
        case .comment:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTVC.className, for: indexPath) as? CommentTVC else { return UITableViewCell() }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
