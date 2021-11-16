//
//  CommunityTVC.swift
//  Remember-iOS
//
//  Created by EUNJU on 2021/11/15.
//

import UIKit

class CommunityTVC: UITableViewCell {

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

    // MARK: - Custom Method Part
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCommunityData(number: Int, data: CommunityContentData) {
        numberLabel.text = "\(number+1)"
        titleLabel.text = data.titleName
        subTitleLabel.text = data.subTitleName
        likeCountLabel.text = data.likeNumber
        chatCountLabel.text = data.chatNumber
    }
    
}
