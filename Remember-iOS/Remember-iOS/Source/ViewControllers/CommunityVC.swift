//
//  CommunityVC.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/13.
//

import UIKit

import Moya

class CommunityVC: BaseViewController {
    private let authProvider = MoyaProvider<MainService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    var mainData: MainResponseData?

    // MARK: - UI Component Part
    
    @IBOutlet weak var communityTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    // MARK: - Vars & Lets Part
    
    var categoryList: [String] = []
    
    // MARK: - Manager
    
    private let manager = PostManager.shared
    
    // MARK: - Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDataList()
        setupTV()
        setupCV()
        setupNavigation()
        fetchMainData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTabbar()
        communityTableView.reloadData()
    }
    
    // MARK: - Custom Method Part
    
    func initDataList() {
//        categoryList.append(contentsOf: [
//            "마케팅/PR/제휴", "IT기획/개발/디자인", "디자이너", "개발", "디자인", "IT 엔지니어", "인공지능/빅데이터"
//        ])
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
    
    func setupNavigation() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func setupTabbar() {
        guard let tabbar = tabBarController as? TabBarVC else { return }
        tabbar.showTabbar()
    }
    
    func fetchMainData() {
        authProvider.request(.getCategoryData) { [weak self] response in // request 부분에 은주가 쓸 case를 넣어주세요!
            switch response { // response 응답이 들어왔을 때
            case .success(let result): // 성공하면 result가 들어오는데 result에 data가 들어가 있어요!
                do {
                    self?.mainData = try result.map(MainResponseData.self)
                    self?.categoryList = self?.mainData?.data?.tagList ?? []
                    print("categoryList", self?.categoryList)
                    self?.categoryCollectionView.reloadData()
                    
                    let url = URL(string: self?.mainData?.data?.image ?? "")
                    
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: url!)
                        DispatchQueue.main.async { self?.bannerImageView.image = UIImage(data: data!) }
                    }
                    
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err): // 실패하면
                print(err.localizedDescription)
            }
        }
    }
}

// MARK: - Extension Part

extension CommunityVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: DetailPostVC.className) as? DetailPostVC else { return }
        vc.index = indexPath.row
        manager.setIndex(to: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CommunityVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTVC.className) as? CommunityTVC else { return UITableViewCell() }
        
        cell.setCommunityData(number: indexPath.row, data: manager.contents[indexPath.row])
        return cell
    }
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
