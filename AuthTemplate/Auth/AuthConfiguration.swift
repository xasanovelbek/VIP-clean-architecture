//
//  AuthConfiguration.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import Foundation
class AuthConfiguration: NSObject {
    class func loginModule(configure viewController: LoginVC) {
        let interactor = LoginInteractor(worker: LoginWorker())
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        presenter.view = viewController
        router.viewController = viewController
    }
    
    class func signinModule(configure viewController: SigninVC) {
        let interactor = SigninInteractor(worker: SigninWorker())
        let presenter = SigninPresenter()
        let router = SigninRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        presenter.view = viewController
        router.viewController = viewController
    }
}
