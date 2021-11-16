//
//  CommentHeader.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/16.
//

import UIKit

import SnapKit
import Then

class CommentHeader: UIView {
    
    // MARK: - UI
    
    private let commentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }
    private let image = UIImageView().then {
        $0.image = ImageLiterals.icbtRightChervon
    }
    private let bottomLine = UIView().then {
        $0.backgroundColor = .gray1
    }

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        render()
    }
    
    convenience init(count: Int) {
        self.init(frame: .zero)
        commentLabel.text = "댓글 \(count)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func render() {
        add(commentLabel) {
            $0.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(16)
            }
        }
        add(image) {
            $0.snp.makeConstraints {
                $0.centerY.equalTo(self.commentLabel.snp.centerY)
                $0.leading.equalTo(self.commentLabel.snp.trailing).offset(7)
                $0.height.equalTo(10)
                $0.width.equalTo(5)
            }
        }
        add(bottomLine) {
            $0.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(1)
            }
        }
    }
    
}
