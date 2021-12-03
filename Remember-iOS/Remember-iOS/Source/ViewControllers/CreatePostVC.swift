//
//  CreatePostVC.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/13.
//

import UIKit

import SnapKit
import Then

extension CGFloat {
    static var keyboardHeight: CGFloat = 0.0
}

final class CreatePostVC: BaseViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var registerButton: UIBarButtonItem!
    @IBOutlet weak var imageButton: UIBarButtonItem!
    @IBOutlet weak var nicknameButton: UIBarButtonItem!
    
    // MARK: - Lazy UI
    
    private lazy var titleTextField = UITextField().then {
        self.setCategoryButtonContentInsets(0.38)
        $0.placeholder = "제목을 입력하세요"
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.borderStyle = .none
        $0.delegate = self
    }
    private lazy var contentTextView = UITextView().then {
        $0.text = placeholder
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .gray2
        $0.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 46, right: 0)
        $0.delegate = self
    }
    
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
    
    // MARK: - Private Properties
    
    private let placeholder = "내용을 입력하세요"
    private var textBottomConstraint: NSLayoutConstraint!
    private var didRegisterNickname = false
    private var canRegister = false {
        didSet { changeRegisterState() }
    }
    
    // MARK: - Manager
    
    private let manager = PostManager.shared
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupNavigationBar()
        setupNotificationCenter()
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
            self.textBottomConstraint = $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            self.textBottomConstraint.isActive = true
        }
    }
    
    override func configUI() {
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
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: - @IBAction
    
    @IBAction func didTappedCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTappedRegister(_ sender: Any) {
        guard let title = titleTextField.text,
              let content = contentTextView.text,
              let category = categoryButton.titleLabel?.text
        else { return }
        
        manager.dispatchPost(tag: category, title: title, content: content) { [weak self] status, message in
            guard let self = self else { return }
            
            switch status {
            case 200:
                print(message)
                self.dismiss(animated: true, completion: nil)
            default:
                print(message)
            }
        }
    }
 
    @IBAction func didTappedImage(_ sender: Any) {
        print("tapped Image...")
    }
    
    @IBAction func didTappedNickname(_ sender: Any) {
        didRegisterNickname.toggle()
        nicknameButton.image = didRegisterNickname ? ImageLiterals.nicknameregisterActive.withRenderingMode(.alwaysOriginal) : ImageLiterals.nicknameregisterInactive.withRenderingMode(.alwaysOriginal)
    }
    
    // MARK: - Selector
    
    @objc
    private func keyboardWillShow(_ notification:NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            CGFloat.keyboardHeight = keyboardHeight
        }
    }
    
    @objc
    private func didTappedCategory() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let itBussinessType = UIAlertAction(title: "IT 기획/개발/디자인", style: .default, handler: { [unowned self] _ in
            self.setCategoryButtonContentInsets(0.48)
            self.categoryButton.setTitle("IT 기획/개발/디자인", for: .normal)
        })
        let designer = UIAlertAction(title: "디자이너", style: .default, handler: { [unowned self] _ in
            self.setCategoryButtonContentInsets(0.67)
            self.categoryButton.setTitle("디자이너", for: .normal)
        })
        let companyLife = UIAlertAction(title: "회사생활", style: .default, handler: { [unowned self] _ in
            self.setCategoryButtonContentInsets(0.67)
            self.categoryButton.setTitle("회사생활", for: .normal)
        })
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(itBussinessType)
        alert.addAction(designer)
        alert.addAction(companyLife)
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
    
    private func changeRegisterState() {
        registerButton.isEnabled = canRegister
    }
}

// MARK: - UITextField, UITextView Delegate
extension CreatePostVC: UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let condition = textField.hasText && contentTextView.hasText && contentTextView.text != placeholder
        canRegister = condition ? true : false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentTextView.becomeFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let condition = titleTextField.hasText && textView.hasText && textView.text != placeholder
        canRegister = condition ? true : false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.textBottomConstraint.constant = -.keyboardHeight + 44
        
        if textView.text == placeholder {
            textView.text.removeAll()
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.textBottomConstraint.constant = -50
        
        if !textView.hasText || textView.text == placeholder {
            textView.text = placeholder
            textView.textColor = .gray2
        }
    }
}
