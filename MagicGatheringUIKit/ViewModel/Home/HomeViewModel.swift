//
//  HomeViewModel.swift
//  MagicGatheringUIKit
//
//  Created by Nguyễn Việt on 16/07/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var data: [Card] = []
    @Published var searchText = ""
    @Published var isLoading: Bool = false

    init() {}
    
    func fetch(_ query: String) async {
        isLoading = true
        if query != "" {
            do {
                let respone: (ListRespone, Int) = try await APIService.shared.GET(endPoint: .searchCard(query: query))
                if (200...299).contains(respone.1) {
                    data = respone.0.data
                } else {
                    data = []
                }
            } catch {
                print(error.localizedDescription)
            }
            isLoading = false

        } else {
            data = []
            isLoading = false

        }

    }
}
