//
//  LoginPresenter.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import Foundation

protocol LoginPresenterProtocol {
    func interactor(_ interactor: LoginInteractorProtocol, didFetch model: LoginEntity.Response)
    func interactor(_ interactor: LoginInteractorProtocol, didErrorWith error: BaseError)
}

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginVCProtocol?
    var interactor: LoginInteractorProtocol?
    
    func interactor(_ interactor: LoginInteractorProtocol, didFetch model: LoginEntity.Response) {
        self.interactor = interactor
        let viewModel = LoginEntity.ViewModel(email: model.email, firstName: model.firstName, lastName: model.lastName)
        view?.hideProgress()
        view?.set(viewModel: viewModel)
    }
    
    func interactor(_ interactor: LoginInteractorProtocol, didErrorWith error: BaseError) {
        self.interactor = interactor
        view?.hideProgress()
        view?.showErrorAlert(with: error.message ?? "")
    }
    
    
}
