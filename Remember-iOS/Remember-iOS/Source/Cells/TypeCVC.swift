//
//  TypeCVC.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/16.
//

import UIKit

class TypeCVC: UICollectionViewCell, UICollectionViewRegisterable {
    static var isFromNib: Bool {
        get { return true }
    }
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var typeLabel: UILabel!

    // MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Public Methods
    
    public func setupData(text: String) {
        typeLabel.text = text
        backgroundColor = .gray1
        layer.cornerRadius = 8
    }
    
}
