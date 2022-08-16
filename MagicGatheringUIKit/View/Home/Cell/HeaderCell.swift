//
//  HeaderCell.swift
//  MagicGatheringUIKit
//
//  Created by Nguyễn Việt on 18/07/2022.
//

import Foundation
import UIKit
import Combine

class HeaderCell: UITableViewHeaderFooterView {
    static let reuseId = "headerCell"
//    var subcription: AnyCancellable?
//
//    let containerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        return view
//    }()
//
//    let textField: UITextField = {
//        let textField = UITextField()
//        textField.backgroundColor = .backgroundColor
//        textField.round(corners: .all)
//        return textField
//    }()
    
          // Single Publisher per cell
//    let searchText = PassthroughSubject<String?, Never>()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func configure() {
//        addSubview(containerView)
//        containerView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        containerView.addSubview(textField)
//        textField.snp.makeConstraints { make in
//            make.top.equalTo(containerView.snp.top)
//            make.bottom.equalTo(containerView.snp.bottom)
//            make.left.equalTo(containerView.snp.left).offset(10)
//            make.right.equalTo(containerView.snp.right).offset(-10)
//
//        }
//
//        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//    }
//
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        searchText.send(textField.text!)
//    }
    
    let containerView: UIView =  {
        let view = UIView()
        return view
    }()
    
    let lbSet: UILabel = {
        let label = UILabel()
        label.text = "Set"
        label.textColor = .blue
        return label
    }()
    
    let lbNumber: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "№"
        return label
    }()
    
    let lbName: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .blue
        return label
    }()
    
    private func configure() {
        contentView.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(lbSet)
        containerView.addSubview(lbNumber)
        containerView.addSubview(lbName)
        
        lbSet.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(containerView).offset(10)
            make.width.equalTo(40)
        }
        
        lbNumber.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.leading.equalTo(lbSet.snp.trailing).offset(10)
        }
        
        lbName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(lbNumber.snp.trailing).offset(10)
            make.trailing.equalTo(containerView).offset(10)
        }
    }
}
