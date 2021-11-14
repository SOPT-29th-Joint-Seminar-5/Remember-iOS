//
//  CommunityVC.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/13.
//

import UIKit

class CommunityVC: BaseViewController {

    @IBOutlet weak var communityTableView: UITableView!
    
    var communityContentList: [CommunityContentData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCommunityContentList()
        setTableView()
    }
    
    func initCommunityContentList() {
        communityContentList.append(contentsOf: [
        CommunityContentData(titleName: "후배가 내 파트장이 된다면???", subTitleName: "회사생활", likeNumber: "564", chatNumber: "80"),
        CommunityContentData(titleName: "이직 횟수가 많으면 잘못한 건가요?", subTitleName: "이직/연봉/커리어", likeNumber: "532", chatNumber: "64"),
        CommunityContentData(titleName: "올해 한국주식 투자하신분들 이익보셨나요?", subTitleName: "경제/제태크", likeNumber: "488", chatNumber: "58"),
        CommunityContentData(titleName: "디자이너 워라밸 실화인가요?", subTitleName: "회사생활", likeNumber: "453", chatNumber: "52"),
        CommunityContentData(titleName: "이직은 어떻게 하는건가요", subTitleName: "이직/연봉/커리어", likeNumber: "422", chatNumber: "44")
        ])
    }
    
    func setTableView() {
        let communityTableXib = UINib(nibName: CommunityTVC.className, bundle: nil)
        communityTableView.register(communityTableXib, forCellReuseIdentifier: CommunityTVC.className)
        
        communityTableView.dataSource = self
        communityTableView.delegate = self
    }
}

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
