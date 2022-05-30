//
//  SigninRouter.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import UIKit

protocol SigninRouterProtocol {
    func routeToMainScreen()
}

class SigninRouter: SigninRouterProtocol {
    
    weak var viewController: SigninVC?
    
    func routeToMainScreen() {
        let navController = viewController?.navigationController
        let destinationVC = ViewController()
        navController?.pushViewController(destinationVC, animated: true)
    }
}
