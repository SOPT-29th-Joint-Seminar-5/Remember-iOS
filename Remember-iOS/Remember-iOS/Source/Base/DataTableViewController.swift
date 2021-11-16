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
    
    private var commentLists: [String] = []
    
    // MARK: - Initializers
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
}
