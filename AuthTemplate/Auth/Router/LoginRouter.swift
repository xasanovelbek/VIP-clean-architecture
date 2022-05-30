//
//  LoginRouter.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import UIKit

protocol LoginRouterProtocol {
    func routeToMainScreen()
    func routeToSignin()
}

class LoginRouter: LoginRouterProtocol {
    
    weak var viewController: LoginVC?
    
    func routeToMainScreen() {
        let navController = viewController?.navigationController
        let destinationVC = ViewController()
        navController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToSignin() {
        let navController = viewController?.navigationController
        let destinationVC = SigninVC()
        navController?.pushViewController(destinationVC, animated: true)
    }
}
