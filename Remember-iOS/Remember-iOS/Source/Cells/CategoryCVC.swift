//
//  CategoryCVC.swift
//  Remember-iOS
//
//  Created by EUNJU on 2021/11/15.
//

import UIKit

class CategoryCVC: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
    }
    
    func setCategoryData(categoryData: String) {
        categoryLabel.text = categoryData
    }

}

extension CategoryCVC {
    func setLabel() {
        categoryLabel.layer.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.953, alpha: 1).cgColor
        categoryLabel.layer.cornerRadius = 3
    }
}
