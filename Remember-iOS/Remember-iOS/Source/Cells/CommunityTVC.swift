//
//  CommunityTVC.swift
//  Remember-iOS
//
//  Created by EUNJU on 2021/11/15.
//

import UIKit

class CommunityTVC: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Vars & Lets Part
    
    static var isFromNib: Bool {
        get {
            return true
        }
    }
    
    // MARK: - UI Component Part
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var chatCountLabel: UILabel!
    
    // MARK: - Life Cycle Part
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        numberLabel.textColor = .black
        numberLabel.text = ""
        titleLabel.text = ""
        subTitleLabel.text = ""
        chatCountLabel.text = ""
    }
    
    // MARK: - Custom Method Part
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCommunityData(number: Int, data: Content) {
        if number < 3 {
            numberLabel.textColor = .main1
        }
        numberLabel.text = "\(number+1)"
        titleLabel.text = data.title
        subTitleLabel.text = data.category[0]
        likeCountLabel.text = "1"
        chatCountLabel.text = "\(data.comment.count)"
    }
    
}
