//
//  RequestError.swift
//  Template
//
//  Created by Elbek Khasanov on 21/05/22.
//

import Foundation

class RequestError: Error {
    var reason: String = ""
    var humanText: String = ""
    var errorType: ErrorCase = .unknown
    
    private var data: Data?
    
    init() {}
    
    init(_ data: Data?) {
        self.data = data
    }
    
    static func errorCase(_ eCase: ErrorCase, internetError: Bool = false) -> RequestError {
        let instance = RequestError(nil)
        
        if !internetError {
            instance.reason = "The Internet connection appears to be offline."
            instance.humanText = "Отсутствует подключение к интернету."
        } else {
            instance.reason = eCase.errorDescription
            instance.humanText = eCase.errorDescription
        }
        instance.errorType = eCase
        return instance
    }
    
}

extension RequestError {
    ///Errors in working with API
    enum ErrorCase: Error, LocalizedError, Equatable {
        /// Token error
        case token
        /// Authorization error
        case unauthorizedRequest
        /// Decoding error
        case decodingError(String?)
        /// Server returned error with status code
        case unexpectedStatusCode(Int)
        /// Request was not filled with all query items
        case emptyQuery
        /// Authorization error
        case failedAuthorization(String)
        case encodingError
        /// Unexpected error
        case unknown
        case custom(String)
        
        var errorDescription: String {
            switch self {
            case .unauthorizedRequest:
                return ""
            case .token:
                return ""
            case .decodingError(let detail):
                return "\(detail ?? "")"
            case .unexpectedStatusCode(let code):
                return " \(code)"
            case .emptyQuery:
                return ""
            case .failedAuthorization(let reason):
                return ": \(reason)"
            case .encodingError:
                return ""
            case .unknown:
                return ""
            case .custom(let message):
                return message
            }
        }
    }
}
