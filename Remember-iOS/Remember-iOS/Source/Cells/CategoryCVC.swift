//
//  CategoryCVC.swift
//  Remember-iOS
//
//  Created by EUNJU on 2021/11/15.
//

import UIKit

class CategoryCVC: UICollectionViewCell {

    // MARK: - UI Component Part
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    // MARK: - Life Cycle Part
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
    }
    
    // MARK: - Custom Method Part
    
    func setCategoryData(categoryData: String) {
        categoryLabel.text = categoryData
    }
}

// MARK: - Extension Part

extension CategoryCVC {
    func setLabel() {
        categoryLabel.layer.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.953, alpha: 1).cgColor
        categoryLabel.layer.cornerRadius = 3
    }
}
