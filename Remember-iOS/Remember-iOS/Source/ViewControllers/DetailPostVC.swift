//
//  DetailPostVC.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/16.
//

import UIKit

import SnapKit
import Then

class DetailPostVC: DataTableViewController {
    
    // MARK: - Lazy UI
    
    private lazy var navigationBar = NavigationBar(root: self)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        render()
    }
    
    // MARK: - Setup Methods
    
    private func render() {
        view.add(navigationBar) {
            $0.snp.makeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide)
                $0.width.equalTo(UIScreen.main.bounds.size.width)
                $0.height.equalTo(48)
            }
        }
        
        guard let commentView = Bundle.main.loadNibNamed("CommentSection", owner: self, options: nil)?.first as? CommentSection else { return }
        commentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 132)
        view.add(commentView){
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
                $0.width.equalTo(UIScreen.main.bounds.size.width)
                $0.height.equalTo(132)
            }
        }
    }
}
