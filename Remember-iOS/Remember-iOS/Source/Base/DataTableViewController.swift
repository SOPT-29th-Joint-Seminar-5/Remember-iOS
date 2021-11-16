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
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        super.init(style: .grouped)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ContentTVC.register(target: tableView)
        CommentTVC.register(target: tableView)
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
}
