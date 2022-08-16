//
//  Init+Ext.swift
//  MagicGatheringUIKit
//
//  Created by Nguyễn Việt on 16/08/2022.
//

import UIKit

enum CustomButtonType {
    case rotate
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .custom)
        self.setTitle(title, for: .normal)
    }
}

extension UIButton {
    
    func config(type: CustomButtonType) {
        self.setTitleColor(.blue, for: .normal)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.round(corners: .all)
        switch type {
        case .rotate:
            self.setTitle("Rotate", for: .normal)
            self.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
        }
    }
}

extension UILabel {
    convenience init(
        title: String = "",
        numberOfLines: Int = 1,
        font: UIFont = .systemFont(ofSize: 16, weight: .regular),
        alignment: NSTextAlignment = .left,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail
    ) {
        self.init(frame: .zero)
        self.text = title
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
        self.lineBreakMode = .byTruncatingTail
    }
}
