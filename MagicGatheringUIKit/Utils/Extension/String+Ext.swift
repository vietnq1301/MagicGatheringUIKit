//
//  String+Ext.swift
//  MagicGathering
//
//  Created by Nguyễn Việt on 10/07/2022.
//

import Foundation
import UIKit
import PocketSVG

extension String {
    func addSymbol() -> NSMutableAttributedString {
        let regex = "\\{[^}]*\\}"
        let mana = self
        let attributedString = NSMutableAttributedString(string: mana)
        let symbols = matches(for: regex, in: mana)
        for symbol in symbols {
            var sym = symbol
            sym = sym.replacingOccurrences(of: "{", with: "")
            sym = sym.replacingOccurrences(of: "}", with: "")
            if let url = URL(string: "https://c2.scryfall.com/file/scryfall-symbols/card-symbols/\(sym).svg") {
                let frame = CGRect(x: 0, y: 0, width: 16, height: 16)
                let svgLayer = SVGLayer(contentsOf: url)
                svgLayer.frame = frame
                let attachment = NSTextAttachment()
                attachment.image = snapshotImage(for: svgLayer)
                attachment.bounds = CGRect(x: 0, y: -2, width: 16, height: 16)
                let replacement = NSAttributedString(attachment: attachment)
                let range = attributedString.string.range(of: symbol)
                if let range = range {
                    let nsRange = NSRange(range, in: attributedString.string)
                    attributedString.replaceCharacters(in: nsRange, with: replacement)
                }
            }
        }
        return attributedString
    }
}
