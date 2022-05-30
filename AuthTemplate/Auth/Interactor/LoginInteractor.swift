//
//  LoginInteractor.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import Foundation

protocol LoginInteractorProtocol {
    func login(email: String, password: String)
}

class LoginInteractor: LoginInteractorProtocol {
    
    private let worker: LoginWorkerProtocol
    
    var presenter: LoginPresenterProtocol?
    
    init(worker: LoginWorkerProtocol) {
        self.worker = worker
    }
    
    func login(email: String, password: String) {
        worker.login(email: email,
                     password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response): self.presenter?.interactor(self, didFetch: response)
            case .failure(let error): self.presenter?.interactor(self, didErrorWith: error)
            }
        }
    }
}
