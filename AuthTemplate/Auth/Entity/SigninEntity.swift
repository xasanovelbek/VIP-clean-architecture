//
//  SigninEntity.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import Foundation
enum SigninEntity {
    struct Request {
        let email: String
        let password: String
        let firstname: String
        let lastname: String
    }
    
    struct Response {
        var email: String?
        var firstName: String?
        var lastName: String?
        var password: String?
        var createdAt: String?
    }
    
    struct ViewModel {
        var email: String?
        var firstName: String?
        var lastName: String?
    }
}
