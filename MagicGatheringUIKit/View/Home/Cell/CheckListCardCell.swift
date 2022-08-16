//
//  CardCell.swift
//  MagicGatheringUIKit
//
//  Created by Nguyễn Việt on 16/07/2022.
//

import UIKit
import SwiftUI
import SnapKit

class CheckListCardCell: UITableViewCell {

    var cardVM: CheckListCardViewModel? {
        didSet {
            guard let cardVM = cardVM else {
                return
            }
            
            lbSet.text = cardVM.set
            lbName.text = cardVM.name
            lbNumber.text = cardVM.number
            lbMana.attributedText = cardVM.mana
        }
    }
    
    let containerView = UIView()
    private let lbSet = UILabel(title: "Set")
    private let lbNumber = UILabel(title: "Number",alignment: .center)
    private let lbName = UILabel(title: "Name")
    private let lbMana = UILabel(title: "Mana")
    private let stackView = VerticalStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.addSubviews([lbSet, lbNumber, stackView])
        stackView.addArrangedSubview(lbName)
        stackView.addArrangedSubview(lbMana)
        
        lbSet.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(containerView).offset(10)
            make.width.equalTo(50)
        }
        
        lbNumber.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.leading.equalTo(lbSet.snp.trailing).offset(10)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(lbNumber.snp.trailing).offset(10)
            make.trailing.equalTo(containerView).offset(-20)

        }
        
        containerView.addBorder(to: .top, in: .lightGray, width: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


