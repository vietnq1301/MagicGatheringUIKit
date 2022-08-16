//
//  CardViewModel.swift
//  MagicGatheringUIKit
//
//  Created by Nguyễn Việt on 16/07/2022.
//

import Foundation

class CardViewModel {
    let card: Card!
    
    init(card: Card) {
        self.card = card
    }
    
    var set: String {
        return card.set.uppercased()
    }
    
    var name: String {
        return card.name
    }
    
    var number: String {
        return card.collectorNumber
    }
    
    var url: String {
        return card.imageUris.normal
    }
    
    var isMultiFaces: Bool {
        return card.cardFaces.count >= 2
    }
    
    var isFlipped: Bool {
        return card.isFlipped
    }
    
    var cardFaces: [CardFace] {
        return card.cardFaces
    }
    
    func getManaSymbols() -> [ManaSymbol] {
        if !isMultiFaces {
            return []
        } else {
            return []
        }
    }
}
