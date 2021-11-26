//
//  NavigationBar.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/16.
//

import UIKit

import SnapKit
import Then

class NavigationBar: UIView {

    // MARK: - UI
    
    private let backButton = UIButton().then {
        $0.setImage(ImageLiterals.iconBack, for: .normal)
        $0.addTarget(self, action: #selector(didTappedBack), for: .touchUpInside)
    }
    private let titleLabel = UILabel().then {
        $0.text = "커뮤니티"
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    private let menuButton = UIButton().then {
        $0.setImage(ImageLiterals.iconMoreVertical, for: .normal)
    }
    private let bottomLine = UIView().then {
        $0.backgroundColor = .gray2
    }
    
    // MARK: - Private Properties
    
    private var root: UIViewController?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        render()
    }
    
    convenience init(root: UIViewController) {
        self.init(frame: .zero)
        self.root = root
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func render() {
        add(backButton) {
            $0.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.width.height.equalTo(44)
            }
        }
        add(titleLabel) {
            $0.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
        add(menuButton) {
            $0.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(16)
                $0.width.height.equalTo(44)
            }
        }
        add(bottomLine) {
            $0.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(1)
            }
        }
    }
    
    // MARK: - Selector
    
    @objc
    private func didTappedBack() {
        root?.navigationController?.popViewController(animated: true)
    }
}
