//
//  NetworkProvider.swift
//  Template
//
//  Created by Elbek Khasanov on 21/05/22.
//

import Foundation
import Combine

enum UploadResponse {
    case progress(percentage: Double)
    case response(_ model: Decodable)
}


class NetworkProvider: NSObject {
    
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }
    
    func sendRequest<Output: Decodable>(with api: BaseApi) -> AnyPublisher<Output, RequestError> {
        
        var endpoint = URLRequest(url: api.path)
        endpoint.httpMethod = api.method
        
        if let header = api.headers {
            endpoint.allHTTPHeaderFields = header
        }
        
        if let body = api.body {
            endpoint.httpBody = body
        }
        
        return self.session
            .dataTaskPublisher(for: endpoint)
            .retry(1)
            .print()
            .receive(on: DispatchQueue.main)
            .mapError { error in
                RequestError.errorCase(.unknown)
            }
            .flatMap { data, response -> AnyPublisher<Output, RequestError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: RequestError.errorCase(.unknown))
                        .eraseToAnyPublisher()
                }
                
                let dataString = String(decoding: data,
                                        as: UTF8.self).lowercased()
                print(dataString)
                
                if (200...299).contains(response.statusCode) {
                    let decodedData = Just(data)
                        .decode(type: Output.self, decoder: JSONDecoder())
                        .mapError { error -> RequestError in
                            let requestError = RequestError()
                            requestError.humanText = "Error in decoding data"
                            requestError.reason = "Decoding error"
                            return requestError
                        }
                        .eraseToAnyPublisher()
                    return decodedData
                } else if response.statusCode == 502 {
                    let error = RequestError()
                    error.reason = "502 Gateway"
                    error.humanText = "Сервер недоступен (502)"
                    
                    
                    
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                } else {
                    let error = RequestError(data)
                    
                    // Сервер вернул неожиданный код статуса
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
                
            }.eraseToAnyPublisher()
    }
    
}
