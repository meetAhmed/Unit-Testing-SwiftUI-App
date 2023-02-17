//
//  NewMockDataService_Test.swift
//  UnitTestingBootcamp_Tests
//
//  Created by Ahmed Ali on 17/02/2023.
//

import Combine
import XCTest
@testable import UnitTestingBootcamp

final class NewMockDataService_Test: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func test_NewMockDataService_downloadItemsWithCombine_doesFail() {
        // Given
        let dataService = NewMockDataService(items: [])
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation(description: "Does throw error")
        let expectation2 = XCTestExpectation(description: "Does throw URL badServerResponse")
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation.fulfill()
                    
                    if error as? URLError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation, expectation2], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
}
