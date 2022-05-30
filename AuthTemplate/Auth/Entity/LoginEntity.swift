//
//  LoginEntity.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import Foundation
enum LoginEntity {
    struct Request {
        let email: String
        let password: String
    }
    
    struct Response {
        var email: String?
        var firstName: String?
        var lastName: String?
        var createdAt: String?
    }
    
    struct ViewModel {
        var email: String?
        var firstName: String?
        var lastName: String?
    }
}
