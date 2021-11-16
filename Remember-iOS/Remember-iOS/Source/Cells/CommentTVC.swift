//
//  CommentTVC.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/16.
//

import UIKit

class CommentTVC: UITableViewCell, UITableViewRegisterable {
    static var isFromNib: Bool {
        get { return true }
    }
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var replyLabel: UILabel!

    // MARK: - Initializers
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Setup Methods
    
    private func configUI() {
        timeLabel.textColor = .gray3
        replyLabel.textColor = .gray3
    }
    
    // MARK: - Public Methods
    
    public func setupData(nickname: String, content: String) {
        timeLabel.text = "3분 전"
        nicknameLabel.text = nickname
        contentLabel.text = content
    }
}
