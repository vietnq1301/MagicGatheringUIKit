//
//  VerticalStackView.swift
//  MagicGatheringUIKit
//
//  Created by Nguyễn Việt on 16/08/2022.
//

import UIKit

class VerticalStackView: UIStackView {
    init(spacing: CGFloat = 0, alignment: UIStackView.Alignment = .leading) {
        super.init(frame: .zero)
        self.spacing = spacing
        self.axis = .vertical
        self.alignment = alignment
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
