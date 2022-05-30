//
//  SigninWorker.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import Foundation

protocol SigninWorkerProtocol {
    func signin(email: String, password: String, firstname: String, lastname: String, onCompletion: @escaping (Result<SigninEntity.Response, BaseError>) -> Void)
    func savedatas(email: String?, password: String?, firstname: String?, lastname: String?, createdAt: String?)
}

class SigninWorker: SigninWorkerProtocol {
    func signin(email: String, password: String, firstname: String, lastname: String, onCompletion: @escaping (Result<SigninEntity.Response, BaseError>) -> Void) {
        
        
        let response = SigninEntity.Response(email: email, firstName: firstname, lastName: lastname, password: password, createdAt: Date().timeIntervalSince1970.description)
        print(response)
        
        onCompletion(.success(response))
        
    }
    
    func savedatas(email: String?, password: String?, firstname: String?, lastname: String?, createdAt: String?) {
        print("saving email", email)
    }
    
    
}
