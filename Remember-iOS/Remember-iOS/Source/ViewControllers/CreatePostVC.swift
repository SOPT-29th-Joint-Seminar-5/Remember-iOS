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
    @IBOutlet weak var imageButton: UIBarButtonItem!
    @IBOutlet weak var nicknameButton: UIBarButtonItem!
    
    // MARK: - UI

    private let categoryButton = UIButton().then {
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
    private var didRegister = false
    
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
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(50)
            }
        }
    }
    
    override func configUI() {
        setCategoryButtonContentInsets(0.38)
        
        contentTextView.text = placeholder
        contentTextView.font = .systemFont(ofSize: 16)
        contentTextView.textColor = .gray2
        contentTextView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 46, right: 0)
        
        imageButton.image = ImageLiterals.btnPhoto.withRenderingMode(.alwaysOriginal)
        nicknameButton.image = ImageLiterals.nicknameregisterInactive.withRenderingMode(.alwaysOriginal)
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
    
    @IBAction func didTappedCancel(_ sender: Any) {
        print("tapped cancel...")
    }
    
    @IBAction func didTappedRegister(_ sender: Any) {
        print("tapped Register...")
    }
 
    @IBAction func didTappedImage(_ sender: Any) {
        print("tapped Image...")
    }
    
    @IBAction func didTappedNickname(_ sender: Any) {
        didRegister.toggle()
        nicknameButton.image = didRegister ? ImageLiterals.nicknameregisterActive.withRenderingMode(.alwaysOriginal) : ImageLiterals.nicknameregisterInactive.withRenderingMode(.alwaysOriginal)
    }
    
    // MARK: - Selector
    
    @objc
    private func didTappedCategory() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let itBussinessType = UIAlertAction(title: "IT 기획/개발/디자인", style: .default, handler: { [unowned self] _ in
            self.setCategoryButtonContentInsets(0.48)
            self.categoryButton.setTitle("IT 기획/개발/디자인", for: .normal)
        })
        let itEngineer = UIAlertAction(title: "IT 엔지니어", style: .default, handler: { [unowned self] _ in
            self.setCategoryButtonContentInsets(0.62)
            self.categoryButton.setTitle("IT 엔지니어", for: .normal)
        })
        let AIType = UIAlertAction(title: "인공지능/빅데이터", style: .default, handler: { [unowned self] _ in
            self.setCategoryButtonContentInsets(0.50)
            self.categoryButton.setTitle("인공지능/빅데이터", for: .normal)
        })
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(itBussinessType)
        alert.addAction(itEngineer)
        alert.addAction(AIType)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - Helper
extension CreatePostVC {
    private func setCategoryButtonContentInsets(_ ratio: CGFloat) {
        let width = (UIScreen.main.bounds.size.width - 32) * ratio
        self.categoryButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: width)
        self.categoryButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: width, bottom: 0, right: 0)
    }
}
