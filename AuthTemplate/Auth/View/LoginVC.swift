//
//  LoginVC.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import UIKit
import SnapKit

protocol LoginVCProtocol: BaseViewProtocol {
    func set(viewModel: LoginEntity.ViewModel)
    var interactor: LoginInteractorProtocol? { get set }
}

class LoginVC: BaseViewController {

    // MARK: - UI Elements
    private lazy var mainContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Hello Again!"
        return label
    }()
    
    private lazy var mainSubtitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.text = "Welcome back you have\nbeen missed"
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
    
    private lazy var recoverPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Recover password", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(loginClicked(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var signinButtonContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var signinButtonTitle: UILabel = {
        let label = UILabel()
        label.text = "Not a member?"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var signinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register now", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(signinClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    var router: LoginRouterProtocol?
    var interactor: LoginInteractorProtocol?
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        AuthConfiguration.loginModule(configure: self)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        AuthConfiguration.loginModule(configure: self)
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
extension LoginVC {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainContainer.setGradientBackground(topColor: .hex("#dfe6e9"),
                                            bottomColor: .hex("#dff9fb"))
    }
    
    //    deinit {
    //        NotificationCenter.default.removeObserver(self)
    //    }
}

// MARK: - UI Constraints
extension LoginVC {
    private func setupMainContainer() {
        self.view.addSubview(mainContainer)
        self.mainContainer.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    private func setupTitles() {
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
    }
    
    private func setupBottomItems() {
        self.mainContainer.addSubview(recoverPasswordButton)
        self.recoverPasswordButton.snp.makeConstraints { make in
            make.right.equalTo(passwordTextField.snp.right)
            make.top.equalTo(passwordTextField.snp.bottom).inset(-15)
        }
        
        self.mainContainer.addSubview(loginButton)
        self.loginButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
            make.top.equalTo(recoverPasswordButton.snp.bottom).inset(-50)
            make.height.equalTo(70)
        }
        
        self.mainContainer.addSubview(signinButtonContainer)
        self.signinButtonContainer.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
        }
        
        self.signinButtonContainer.addSubview(signinButtonTitle)
        self.signinButtonTitle.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
        
        self.signinButtonContainer.addSubview(signinButton)
        self.signinButton.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(signinButtonTitle.snp.right).inset(-8)
        }
    }
}

// MARK: - Actions
extension LoginVC {
    @objc func loginClicked(_ sender: UIButton) {
        sender.impulse()
        self.showProgress()
        interactor?.login(email: usernameTextField.tf.text ?? "",
                          password: passwordTextField.tf.text ?? "")
    }
    
    @objc func signinClicked(_ sender: UIButton) {
        sender.impulse()
        router?.routeToSignin()
    }
    
    @objc func keyboardWillAppear(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            let y = self.loginButton.frame.maxY
            let containerHeight = self.mainContainer.frame.height
            let space = containerHeight - y
            let offset = (keyboardHeight - space + 16)
            if keyboardHeight > offset {
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

// MARK: - Presenter
extension LoginVC: LoginVCProtocol {
    func set(viewModel: LoginEntity.ViewModel) {
        router?.routeToMainScreen()
    }
}
