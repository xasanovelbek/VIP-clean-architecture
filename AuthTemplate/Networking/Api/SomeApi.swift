//
//  SomeApi.swift
//  Template
//
//  Created by Elbek Khasanov on 22/05/22.
//

import Foundation


enum SomeApi: BaseApi {
    private var baseurl: URL { URL(string: "www.url.")! }
    
    case someFunc
    case someFuncWith(data: Data)
}

extension SomeApi {
    var path: URL {
        switch self {
        case .someFunc:
            return baseurl.appendingPathComponent("/someURL")
        case .someFuncWith:
            return baseurl.appendingPathComponent("/someURL2")
        }
    }
    
    var method: String {
        switch self {
        case .someFunc:
            return "GET"
        case .someFuncWith:
            return "POST"
        }
    }
    
    var headers: [String : String]? {
        var header: [String: String] = ["X-Client-Type": "51"]
        
        switch self {
        case .someFunc:
            header["some_header"] = "header"
        case .someFuncWith: break
            
        }
        return header
    }
    
    var body: Data? {
        var encodedData: Data?
        switch self {
        case .someFunc: break
        case .someFuncWith(let data):
            encodedData = try? JSONEncoder().encode(data)
        }
        return encodedData
    }
    
}
