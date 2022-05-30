//
//  HomeApi.swift
//  Template
//
//  Created by Elbek Khasanov on 22/05/22.
//

import Foundation
import Combine
protocol SomeApiServiceProtocol {
    func someFunc(with username: String, onCompletion: @escaping (Result<TestData?, RequestError>) -> Void)
}

class SomeApiService: SomeApiServiceProtocol {
    
    private let provider = NetworkProvider()
    
    private var cancellables = Set<AnyCancellable>()
    
    func someFunc(with username: String,
                  onCompletion: @escaping (Result<TestData?, RequestError>) -> Void) {
        let api: SomeApi = .someFunc
        
        provider.sendRequest(with: api)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    onCompletion(.failure(error))
                    break
                }
            } receiveValue: { response in
                onCompletion(.success(response))
            }
            .store(in: &cancellables)
  }
}

struct TestData: Decodable {
    
}
