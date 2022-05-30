//
//  SigninPresenter.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import Foundation
protocol SigninPresenterProtocol {
    func interactor(_ interactor: SigninInteractorProtocol, didFetch model: SigninEntity.Response)
    func interactor(_ interactor: SigninInteractorProtocol, didErrorWith error: BaseError)
}

class SigninPresenter: SigninPresenterProtocol {
    
    
    weak var view: SigninVCProtocol?
    var interactor: SigninInteractorProtocol?
    
    func interactor(_ interactor: SigninInteractorProtocol, didFetch model: SigninEntity.Response) {
        self.interactor = interactor
        
        self.interactor?.saveDatas(email: model.email, password: model.password, firstname: model.firstName, lastname: model.lastName, createdAt: model.createdAt)
        
        let viewModel = SigninEntity.ViewModel(email: model.email, firstName: model.firstName, lastName: model.lastName)
        view?.hideProgress()
        view?.set(viewModel: viewModel)
    }
    
    func interactor(_ interactor: SigninInteractorProtocol, didErrorWith error: BaseError) {
        self.interactor = interactor
        view?.hideProgress()
        view?.showErrorAlert(with: error.message ?? "")
    }
    
}
