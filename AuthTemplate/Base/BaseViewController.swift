//
//  BaseViewController.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import UIKit
import SnapKit
protocol BaseViewProtocol: AnyObject {
    func showErrorAlert(with msg: String)
    func showProgress()
    func hideProgress()
}

class BaseViewController: UIViewController, BaseViewProtocol {
    
    private var indicatorHidden = true
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.color = .red
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservers()
        setupFirstRequests()
    }
    
    func setupViews() {
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.view.backgroundColor = .clear
        // loading indicator
    }
    
    func setupObservers() {
        // loading indicator
    }
    
    func setupFirstRequests() {
        
    }
    
    func showErrorAlert(with msg: String) {
        let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showProgress() {
        self.indicatorHidden = false
        self.view.addSubview(indicator)
        self.indicator.center = self.view.center
        self.indicator.startAnimating()
    }
    
    func hideProgress() {
        self.indicatorHidden = true
        self.indicator.removeFromSuperview()
    }
}
