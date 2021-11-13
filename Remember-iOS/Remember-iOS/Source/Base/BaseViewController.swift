//
//  BaseViewController.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/13.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Manage Memory
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit BaseViewController instance")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        /// Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup Method
    
    func render() {
        // override Layout
    }
    
    func configUI() {
        // override configuration
    }

    func setData() {
        // Override Set Data
    }
}
