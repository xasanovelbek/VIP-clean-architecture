//
//  BaseApi.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 30/05/22.
//

import Foundation
protocol BaseApi {
    var path: URL { get }
    var method: String { get }
    var headers: [String : String]? { get }
    var body: Data? { get }
}
