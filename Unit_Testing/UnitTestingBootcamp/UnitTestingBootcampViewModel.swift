//
//  UnitTestingBootcampViewModel.swift
//  UnitTestingBootcamp
//
//  Created by Ahmed Ali on 16/02/2023.
//

import Combine
import Foundation

class UnitTestingBootcampViewModel: ObservableObject {
    @Published var isPremium: Bool
    @Published var data: [String] = []
    @Published var selectedItem: String?
    let dataService: NewDataServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(isPremium: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItems(item: String) {
        guard !item.isEmpty else { return }
        data.append(item)
    }
    
    func selectedItem(item: String) {
        if let x = data.first(where: { $0 == item }) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    func downloadItemsWithEscaping() {
        dataService.downloadItemsWithEscaping { [weak self] items in
            self?.data = items
        }
    }
    
    func downloadItemsWithCombine() {
        dataService.downloadItemsWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] items in
                self?.data = items
            }
            .store(in: &cancellables)
    }
}
