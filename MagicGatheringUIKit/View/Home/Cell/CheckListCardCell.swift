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
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    let containerView: UIView =  {
        let view = UIView()
        return view
    }()
    
    let lbSet: UILabel = {
        let label = UILabel()
        label.text = "Set"
        return label
    }()
    
    let lbNumber: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
    
        label.text = "Number"
        return label
    }()
    
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        return stackView
    }()
    
    let lbName: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let lbMana: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
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
}


