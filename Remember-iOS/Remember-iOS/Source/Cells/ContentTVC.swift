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
    
    // MARK: - Properties
    
    public var index: Int = 0
    
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
    
    private func calculateCellWidth(index: Int) -> CGFloat {
        let label = UILabel()
        label.text = manager.contents[self.index].category[index]
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        return label.frame.width + 20
    }
    
    // MARK: - Public Methods
    
    public func setupContentData(idx: Int) {
        // set dummy data
        print("현재 index: \(idx)")
        print("현재 Title: \(manager.contents[idx].title)")
        titleLabel.text = manager.contents[idx].title
        nicknameLabel.text = manager.contents[idx].nickname
        jobLabel.text = manager.contents[idx].job
        timeLabel.text = manager.contents[idx].time
        contentLabel.text = manager.contents[idx].content
        contentLabel.addCharacterSpacing(paragraphValue: 5)
    }
}

// MARK: - UICollectionViewDataSource
extension ContentTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.contents[index].category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCVC.className, for: indexPath) as? TypeCVC else { return UICollectionViewCell() }
        cell.setupData(text: manager.contents[index].category[indexPath.item])
        
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
        return CGSize(width: calculateCellWidth(index: indexPath.item), height: collectionView.frame.height)
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
