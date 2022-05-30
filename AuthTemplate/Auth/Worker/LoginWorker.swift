//
//  LoginWorker.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import Foundation

protocol LoginWorkerProtocol {
    func login(email: String, password: String, onCompletion: @escaping (Result<LoginEntity.Response, BaseError>) -> Void)
}

class LoginWorker: LoginWorkerProtocol {
    func login(email: String, password: String, onCompletion: @escaping (Result<LoginEntity.Response, BaseError>) -> Void) {
        
        let response = LoginEntity.Response(email: email, firstName: "Elbek", lastName: "Khasanov", createdAt: "12.12.12")
        
        
        onCompletion(.success(response))
        
    }
}
