//
//  SigninInteractor.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import Foundation
protocol SigninInteractorProtocol {
    func signin(email: String, password: String, firstname: String, lastname: String)
    func saveDatas(email: String?, password: String?, firstname: String?, lastname: String?, createdAt: String?)
}

class SigninInteractor: SigninInteractorProtocol {

    private let worker: SigninWorkerProtocol
    
    var presenter: SigninPresenterProtocol?
    
    init(worker: SigninWorkerProtocol) {
        self.worker = worker
    }
    
    func signin(email: String, password: String, firstname: String, lastname: String) {
        worker.signin(email: email, password: password, firstname: firstname, lastname: lastname) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response): self.presenter?.interactor(self, didFetch: response)
                case .failure(let error): self.presenter?.interactor(self, didErrorWith: error)
            }
        }
    }
    
    func saveDatas(email: String?, password: String?, firstname: String?, lastname: String?, createdAt: String?) {
        worker.savedatas(email: email, password: password, firstname: firstname, lastname: lastname, createdAt: createdAt)
    }
    
    
}
