//
//  CommentSection.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/16.
//

import UIKit

class CommentSection: UIView {

    // MARK: - @IBOutlet
    
    @IBOutlet weak var commentTextView: UITextView!
    
    // MARK: - Properties
    
    public weak var vc: DetailPostVC?
    
    // MARK: - Manager
    
    private let manager = PostManager.shared
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func touchUpSend(_ sender: Any) {
        guard let text = commentTextView.text else { return }
        print(text)
    }
}
