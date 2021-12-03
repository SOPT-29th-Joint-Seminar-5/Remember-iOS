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
    var listData: MainListResponseData?

    // MARK: - UI Component Part
    
    @IBOutlet weak var communityTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    // MARK: - Vars & Lets Part
    
    var categoryList: [String] = []
    var contentList: [MainList] = []
    
    // MARK: - Manager
    
    private let manager = PostManager.shared
    
    // MARK: - Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        setupCV()
        setupNavigation()
        fetchMainData()
        fetchListData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTabbar()
    }
    
    // MARK: - Custom Method Part
    
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
        authProvider.request(.category) { [weak self] response in
            switch response {
            case .success(let result):
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
    
    func fetchListData() {
        authProvider.request(.main) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    self?.listData = try result.map(MainListResponseData.self)
                    self?.contentList = self?.listData?.data?.mainList ?? []
                    print("categoryList", self?.categoryList)
                    self?.communityTableView.reloadData()
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
        return contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTVC.className) as? CommunityTVC else { return UITableViewCell() }
        
        cell.setCommunityData(number: indexPath.row, data: contentList[indexPath.row])
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
