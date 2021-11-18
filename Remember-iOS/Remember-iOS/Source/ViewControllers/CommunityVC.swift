//
//  CommunityVC.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/13.
//

import UIKit

class CommunityVC: BaseViewController {

    // MARK: - UI Component Part
    
    @IBOutlet weak var communityTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    // MARK: - Vars & Lets Part
    
    var communityContentList: [CommunityContentData] = []
    var categoryList: [String] = []
    
    // MARK: - Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDataList()
        setupTV()
        setupCV()
    }
    
    // MARK: - Custom Method Part
    
    func initDataList() {
        communityContentList.append(contentsOf: [
        CommunityContentData(titleName: "후배가 내 파트장이 된다면???", subTitleName: "회사생활", likeNumber: "564", chatNumber: "80"),
        CommunityContentData(titleName: "이직 횟수가 많으면 잘못한 건가요?", subTitleName: "이직/연봉/커리어", likeNumber: "532", chatNumber: "64"),
        CommunityContentData(titleName: "올해 한국주식 투자하신분들 이익보셨나요?", subTitleName: "경제/제태크", likeNumber: "488", chatNumber: "58"),
        CommunityContentData(titleName: "디자이너 워라밸 실화인가요?", subTitleName: "회사생활", likeNumber: "453", chatNumber: "52"),
        CommunityContentData(titleName: "이직은 어떻게 하는건가요", subTitleName: "이직/연봉/커리어", likeNumber: "422", chatNumber: "44")
        ])
        
        categoryList.append(contentsOf: [
            "마케팅/PR/제휴", "IT기획/개발/디자인", "디자이너", "개발", "디자인", "마케팅/PR/제휴", "마케팅/PR/제휴"
        ])
    }
    
    func setupTV() {
        CommunityTVC.register(target: communityTableView)
        
        communityTableView.dataSource = self
        communityTableView.delegate = self
    }
    
    func setupCV() {
        CategoryCVC.register(target: categoryCollectionView)
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
}

// MARK: - Extension Part

extension CommunityVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}

extension CommunityVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communityContentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTVC.className) as? CommunityTVC else { return UITableViewCell() }
        
        cell.setCommunityData(number: indexPath.row, data: communityContentList[indexPath.row])
        return cell
    }
}

extension CommunityVC: UICollectionViewDelegate {
    
}

extension CommunityVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: categoryList[indexPath.item].size(withAttributes:
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width + 8, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension CommunityVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.className, for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
        cell.setCategoryData(categoryData: categoryList[indexPath.row])
        return cell
    }
}
