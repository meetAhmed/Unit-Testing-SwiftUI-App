//
//  UnitTestingBootcampViewModel_Test.swift
//  UnitTestingBootcamp_Tests
//
//  Created by Ahmed Ali on 16/02/2023.
//

import Combine
import XCTest
@testable import UnitTestingBootcamp

// Naming structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Testing structure: Given, When, Then

final class UnitTestingBootcampViewModel_Test: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeTrue() {
        // Given
        let isUserPremium = true
        
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: isUserPremium)
        
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            // Given
            let isUserPremium = Bool.random()
            
            // When
            let vm = UnitTestingBootcampViewModel(isPremium: isUserPremium)
            
            // Then
            XCTAssertEqual(vm.isPremium, isUserPremium)
        }
    }
    
    func test_UnitTestingBootcampViewModel_data_shouldBeEmpty() {
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(vm.data.isEmpty)
    }
    
    func test_UnitTestingBootcampViewModel_data_shouldAddItem() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItems(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertFalse(vm.data.isEmpty)
        XCTAssertEqual(vm.data.count, loopCount)
        XCTAssertNotEqual(vm.data.count, 0)
    }
    
    func test_UnitTestingBootcampViewModel_data_shouldNotBlackString() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // When
        vm.addItems(item: "")
        
        // Then
        XCTAssertFalse(vm.data.isEmpty)
        XCTAssertEqual(vm.data.count, 0)
        XCTAssertNotEqual(vm.data.count, 1)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldStartAsNil() {
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertNil(vm.selectedItem == nil)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItems() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // When
        vm.selectedItem(item: UUID().uuidString)
        
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // When
        let newItem = UUID().uuidString
        vm.addItems(item: newItem)
        vm.selectedItem(item: newItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestingBootcampViewModel_downloadItemsWithEscaping_shouldReturnItems() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // When
        let expectation = XCTestExpectation(description: "Should return items from 3 seconds")
        
        vm.$data
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        
        vm.downloadItemsWithEscaping()
        
        // Then
        
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.data.count, 0)
    }
    
    func test_UnitTestingBootcampViewModel_downloadItemsWithCombine_shouldReturnItems() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // When
        let expectation = XCTestExpectation(description: "Should return items from a second")
        
        vm.$data
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        
        vm.downloadItemsWithEscaping()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.data.count, 0)
    }
}
