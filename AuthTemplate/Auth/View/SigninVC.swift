//
//  SigninVC.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import UIKit

protocol SigninVCProtocol: BaseViewProtocol {
    func set(viewModel: SigninEntity.ViewModel)
    var interactor: SigninInteractorProtocol? { get set }
}

class SigninVC: BaseViewController {

    // MARK: - UI Elements
    private lazy var mainContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .highlighted)
        
        return button
    }()

    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Welcome to the app!"
        return label
    }()
    
    private lazy var mainSubtitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.text = "Welcome you have\nbeen missed"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var usernameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Enter username"
        return textField
    }()
    
    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Password"
        return textField
    }()
    
    private lazy var firstnameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Firstname"
        return textField
    }()
    
    private lazy var lastnameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Lastname"
        return textField
    }()
    
    private lazy var signinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(signinClicked(_:)), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    var router: SigninRouterProtocol?
    var textFields: [CustomTextField] = []
    var interactor: SigninInteractorProtocol?
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        AuthConfiguration.signinModule(configure: self)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        AuthConfiguration.signinModule(configure: self)
    }
    
    
    override func setupViews() {
        super.setupViews()
        self.navigationController?.navigationBar.isHidden = true
        self.setupMainContainer()
        self.setupTitles()
        self.setupTextFields()
        self.setupBottomItems()
    }
    
    override func setupObservers() {
        super.setupObservers()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
}
// MARK: - View Controller Life Cycle
extension SigninVC {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainContainer.setGradientBackground(topColor: .hex("#dfe6e9"),
                                            bottomColor: .hex("#dff9fb"))
    }
    
}

// MARK: - UI Constraints
extension SigninVC {
    private func setupMainContainer() {
        self.view.addSubview(mainContainer)
        self.mainContainer.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupTitles() {
        self.mainContainer.addSubview(backButton)
        self.backButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(48)
            make.height.width.equalTo(32)
        }
        
        self.mainContainer.addSubview(mainTitle)
        self.mainTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(140)
        }
        
        self.mainContainer.addSubview(mainSubtitle)
        self.mainSubtitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(mainTitle.snp.bottom).inset(-16)
        }
    }
    
    private func setupTextFields() {
        self.mainContainer.addSubview(usernameTextField)
        self.usernameTextField.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
            make.height.equalTo(70)
            make.top.equalTo(mainSubtitle.snp.bottom).inset(-40)
        }

        self.mainContainer.addSubview(passwordTextField)
        self.passwordTextField.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
            make.height.equalTo(70)
            make.top.equalTo(usernameTextField.snp.bottom).inset(-10)
        }
        
        self.mainContainer.addSubview(firstnameTextField)
        self.firstnameTextField.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
            make.height.equalTo(70)
            make.top.equalTo(passwordTextField.snp.bottom).inset(-10)
        }
        
        self.mainContainer.addSubview(lastnameTextField)
        self.lastnameTextField.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
            make.height.equalTo(70)
            make.top.equalTo(firstnameTextField.snp.bottom).inset(-10)
        }
        self.textFields = []
        self.textFields.append(contentsOf: [usernameTextField, passwordTextField, firstnameTextField, lastnameTextField])
    }
    
    private func setupBottomItems() {

        self.mainContainer.addSubview(signinButton)
        self.signinButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
            make.top.equalTo(lastnameTextField.snp.bottom).inset(-50)
            make.height.equalTo(70)
        }
    }
}
// MARK: - Actions
extension SigninVC {
    @objc func signinClicked(_ sender: UIButton) {
        sender.impulse()
        self.showProgress()
        interactor?.signin(email: usernameTextField.tf.text ?? "",
                           password: passwordTextField.tf.text ?? "",
                           firstname: firstnameTextField.tf.text ?? "",
                           lastname: lastnameTextField.tf.text ?? "")
    }
    
    @objc func keyboardWillAppear(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            guard let activeTextField = self.textFields.first(where:  { $0.tf.isFirstResponder }) else { return }
            let y = activeTextField.frame.maxY
            let containerHeight = self.mainContainer.frame.height
            let space = containerHeight - y
            let offset = (keyboardHeight - space + 16)
            print(offset)
            if keyboardHeight > offset && offset > 0 {
                UIView.animate(withDuration: 1.0) {
                    self.view.frame.origin.y = -offset
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.5) {
            self.view.frame.origin.y = 0
        }
    }
}

extension SigninVC: SigninVCProtocol {
    func set(viewModel: SigninEntity.ViewModel) {
        router?.routeToMainScreen()
    }
}
