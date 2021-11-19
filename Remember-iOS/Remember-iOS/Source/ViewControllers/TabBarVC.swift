//
//  TabBarVC.swift
//  Remember-iOS
//
//  Created by EUNJU on 2021/11/19.
//

import UIKit

class TabBarVC: UITabBarController {
    
    // MARK: - Vars & Lets Part
    
    let writeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 56, height: 56))

    // MARK: - Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupTabbar()
        setupWriteButton()
    }
    
    // MARK: - Custom Method Part
    
    private func configUI() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().tintColor = .black
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
    
    private func setupTabbar() {
        let storyboard = UIStoryboard.init(name: "Community", bundle: nil)
        let cardTab = storyboard.instantiateViewController(identifier: "EmptyVC")
        cardTab.tabBarItem = UITabBarItem(title: "명함첩", image: ImageLiterals.iconNameCardUnselected.withRenderingMode(.alwaysOriginal), selectedImage: ImageLiterals.iconNameCardSelected.withRenderingMode(.alwaysOriginal))
        
        let careerTab = storyboard.instantiateViewController(identifier: "EmptyVC")
        careerTab.tabBarItem = UITabBarItem(title: "커리어", image: ImageLiterals.iconMessagecircleUnseleted.withRenderingMode(.alwaysOriginal), selectedImage: ImageLiterals.iconMessagecircleSeleted.withRenderingMode(.alwaysOriginal))
        
        let tab = UIViewController()
        tab.tabBarItem = UITabBarItem()
        
        let communityTab = storyboard.instantiateViewController(identifier: "CommunityNavi")
        communityTab.tabBarItem = UITabBarItem(title: "커뮤니티", image: ImageLiterals.icbtComment.withRenderingMode(.alwaysOriginal), selectedImage: ImageLiterals.messageSelected.withRenderingMode(.alwaysOriginal))
        
        let mypageTab = storyboard.instantiateViewController(identifier: "EmptyVC")
        mypageTab.tabBarItem = UITabBarItem(title: "마이페이지", image: ImageLiterals.iconUserUnseleted.withRenderingMode(.alwaysOriginal), selectedImage: ImageLiterals.iconUserSelected.withRenderingMode(.alwaysOriginal))
        
        let tabs =  [cardTab, careerTab, tab, communityTab, mypageTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = communityTab
    }
    
    private func setupWriteButton() {
        var writeTabFrame = writeButton.frame
        writeTabFrame.origin.y = self.tabBar.frame.minY - writeButton.frame.height / 1.2
        writeTabFrame.origin.x = view.bounds.width / 2 - writeTabFrame.size.width / 2
        writeButton.frame = writeTabFrame
        
        writeButton.layer.cornerRadius = writeTabFrame.height / 2
        view.addSubview(writeButton)
        
        writeButton.setImage(ImageLiterals.writeIcon, for: .normal)
        writeButton.addTarget(self, action: #selector(touchUpWrite), for: .touchUpInside)
    }
    
    // MARK: - Helper
    
    public func hideTabbar() {
        tabBar.isHidden = true
        writeButton.isHidden = true
    }
    
    public func showTabbar() {
        tabBar.isHidden = false
        writeButton.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.view.bringSubviewToFront(self.writeButton)
        }
    }
    
    // MARK: - Selector
    
    @objc
    private func touchUpWrite() {
        let storyboard = UIStoryboard(name: "Community", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreateNavi")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

