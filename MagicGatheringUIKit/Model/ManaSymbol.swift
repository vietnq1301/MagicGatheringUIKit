//
//  ManaSymbol.swift
//  MagicGathering
//
//  Created by Nguyễn Việt on 10/07/2022.
//

import Foundation

struct ManaSymbol: Identifiable, Hashable {
    var id: UUID
    var symbol: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ManaSymbolContainer: Identifiable {
    let id = UUID()
    var data = [ManaSymbol]()
}
