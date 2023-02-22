//
//  NewMockDataService.swift
//  UnitTestingBootcamp
//
//  Created by Ahmed Ali on 17/02/2023.
//

import Foundation
import Combine

protocol NewDataServiceProtocol {
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> ())
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

class NewMockDataService: NewDataServiceProtocol {
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? ["One", "Two", "Three"]
    }
    
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap {
                guard !$0.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return $0
            }
            .eraseToAnyPublisher()
    }
}
