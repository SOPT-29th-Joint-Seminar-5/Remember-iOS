//
//  ContentTVC.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/16.
//

import UIKit

class ContentTVC: UITableViewCell, UITableViewRegisterable {
    static var isFromNib: Bool {
        get { return true }
    }
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    // MARK: - Manager
    
    private let manager = PostManager.shared
    
    // MARK: - Initializers
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Setup Methods
    
    private func configUI() {
        jobLabel.textColor = .gray2
        timeLabel.textColor = .gray4
        viewLabel.textColor = .gray3
        likeLabel.textColor = .gray3
    }
    
    private func setupCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        TypeCVC.register(target: categoryCollectionView)
    }
    
    // MARK: - Private Methods
    
    private func calculateCellWidth() -> CGFloat {
        let label = UILabel()
        label.text = manager.tagName
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        return label.frame.width + 20
    }
    
    // MARK: - Public Methods
    
    public func setupData() {
        print("manager.title", manager.title)
        
        titleLabel.text = manager.title
        nicknameLabel.text = manager.nickname ?? "닉네임2"
        jobLabel.text = manager.duty ?? "iOS개발자"
        timeLabel.text = "8분 전"
        viewLabel.text = "조회 \(manager.views)"
        likeLabel.text = "좋아요 \(manager.likes)"
        contentLabel.text = manager.content
        contentLabel.addCharacterSpacing(paragraphValue: 5)
        categoryCollectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource
extension ContentTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCVC.className, for: indexPath) as? TypeCVC else { return UICollectionViewCell() }
        cell.setupData(text: manager.tagName)
        
        switch indexPath.item {
        case 0:
            cell.typeLabel.textColor = .main1
        default:
            cell.typeLabel.textColor = .gray4
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ContentTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: calculateCellWidth(), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
