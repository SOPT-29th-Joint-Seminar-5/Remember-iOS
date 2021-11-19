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
    
    // MARK: - UI
    
    private var commentSection: CommentSection?
    
    // MARK: - Private Properties
    
    private let placeholder = "닉네임님 생각은 어떠세요?"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupTextView()
        render()
        setupTabbar()
    }
    
    // MARK: - Setup Methods
    
    private func setupTextView() {
        commentSection = Bundle.main.loadNibNamed("CommentSection", owner: self, options: nil)?.first as? CommentSection
        
        commentSection?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 132)
        commentSection?.makeShadow(.gray2, 0.2, CGSize(width: 0, height: -5), 3)
        
        commentSection?.commentTextView.delegate = self
        commentSection?.commentTextView.font = .systemFont(ofSize: 16)
        commentSection?.commentTextView.text = placeholder
        commentSection?.commentTextView.textColor = .gray2
    }
    
    private func render() {
        view.add(navigationBar) {
            $0.snp.makeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide)
                $0.width.equalTo(UIScreen.main.bounds.size.width)
                $0.height.equalTo(48)
            }
        }
        
        guard let commentView = commentSection else { return }
        view.add(commentView){
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
                $0.width.equalTo(UIScreen.main.bounds.size.width)
                $0.height.equalTo(132)
            }
        }
    }
    
    private func setupTabbar() {
        guard let tabbar = tabBarController as? TabBarVC else { return }
        tabbar.hideTabbar()
    }
}

// MARK: - UITextViewDelegate
extension DetailPostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text.removeAll()
            textView.textColor = .black
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.commentSection?.transform = CGAffineTransform(translationX: 0, y: -300)
        }, completion: nil)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == placeholder || !textView.hasText {
            textView.text = placeholder
            textView.textColor = .gray2
        }
        
        UIView.animate(withDuration: 0.0, delay: 0, options: .curveEaseInOut, animations: {
            self.commentSection?.transform = .identity
        }, completion: nil)
    }
}
