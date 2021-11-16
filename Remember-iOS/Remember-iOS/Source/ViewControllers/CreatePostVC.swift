//
//  CreatePostVC.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/13.
//

import UIKit

import SnapKit
import Then

class CreatePostVC: BaseViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var registerButton: UIBarButtonItem!
    
    // MARK: - UI

    private let categoryButton = UIButton().then {
        let width = (UIScreen.main.bounds.size.width - 32) * 0.38
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: width)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: width, bottom: 0, right: 0)
        $0.setTitle("커뮤니티를 선택해 주세요", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16)
        $0.setImage(ImageLiterals.icbtDropdown, for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .gray1
        $0.addTarget(self, action: #selector(didTappedCategory), for: .touchUpInside)
    }
    private let titleTextField = UITextField().then {
        $0.placeholder = "제목을 입력하세요"
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.borderStyle = .none
    }
    private let contentTextView = UITextView()
    
    // MARK: - Private Properties
    
    private let placeholder = "내용을 입력하세요"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - Override Methods
    
    override func viewDidLayoutSubviews() {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: titleTextField.frame.size.height-3, width: titleTextField.frame.width, height: 1)
        bottomBorder.backgroundColor = UIColor.gray2.cgColor
        titleTextField.layer.addSublayer((bottomBorder))
    }
    
    override func render() {
        view.add(categoryButton) {
            $0.snp.makeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(16)
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.height.equalTo(40)
            }
        }
        
        view.add(titleTextField) {
            $0.snp.makeConstraints {
                $0.top.equalTo(self.categoryButton.snp.bottom)
                $0.leading.trailing.equalTo(self.categoryButton)
                $0.height.equalTo(50)
            }
        }
        
        view.add(contentTextView) {
            $0.snp.makeConstraints {
                $0.top.equalTo(self.titleTextField.snp.bottom)
                $0.leading.trailing.equalTo(self.categoryButton)
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(46)
            }
        }
    }
    
    override func configUI() {
        contentTextView.text = placeholder
        contentTextView.font = .systemFont(ofSize: 16)
        contentTextView.textColor = .gray2
        contentTextView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 46, right: 0)
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIColor.gray2.as1ptImage()
        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 18.0, weight: .semibold)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.topItem?.title = "게시글 쓰기"
    }
    
    // MARK: - @IBAction
    
    @IBAction func didTappedRegister(_ sender: Any) {
        print("tapped Register...")
    }
 
    // MARK: - Selector
    
    @objc
    private func didTappedCategory() {
        print("tapped Category...")
    }
    
}
