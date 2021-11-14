//
//  CommunityTVC.swift
//  Remember-iOS
//
//  Created by EUNJU on 2021/11/15.
//

import UIKit

class CommunityTVC: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var chatCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

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
