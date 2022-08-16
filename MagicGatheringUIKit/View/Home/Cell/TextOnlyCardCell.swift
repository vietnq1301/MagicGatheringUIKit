//
//  TextOnlyCardCell.swift
//  MagicGatheringUIKit
//
//  Created by Nguyễn Việt on 13/08/2022.
//

import UIKit

class TextOnlyCardCell: UITableViewCell {
    
    var cardVM: TextOnlyCardViewModel? {
        didSet {
            setupUI()
            setupData()
        }
    }
    
    let container: UIView = {
        let view = UIView()
        return view
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.addBorders(to: [.top, .bottom], in: .black, width: 2)

    }
    
    func setupData() {
        guard let cardVM = cardVM else {
            return
        }
        
        let cards = cardVM.generateData()
        cards.forEach { card in
            let view = generateView(card: card)
            stackView.addArrangedSubview(view)
        }
    }
    
    func generateView(card: BasicCard) -> UIView {
        let view = UIView()
        let title = UILabel()
        title.numberOfLines = 0
        title.text = card.title
        title.font = .systemFont(ofSize: 20, weight: .semibold)

        let mana = UILabel()
        mana.numberOfLines = 0
        mana.attributedText = card.mana
        mana.sizeToFit()

        let type = UILabel()
        type.numberOfLines = 0
        type.text = card.type
        type.sizeToFit()

        let oracleText = UILabel()
        oracleText.numberOfLines = 0
        oracleText.lineBreakMode = .byWordWrapping
        oracleText.font = .systemFont(ofSize: 16, weight: .regular)
        let attrOracleText = card.oracleText
        oracleText.attributedText = attrOracleText.addSymbol()
        
        let divider1 = UIView()
        divider1.backgroundColor = .separator
        divider1.isHidden = card.title.isEmpty ? true : false
        
        let divider2 = UIView()
        divider2.backgroundColor = .separator
        divider2.isHidden = card.mana.string.isEmpty ? true : false

        let divider3 = UIView()
        divider3.backgroundColor = .separator
        divider3.isHidden = card.type.isEmpty ? true : false

        let divider4 = UIView()
        divider4.backgroundColor = .separator
        divider4.isHidden = card.oracleText.isEmpty ? true : false

        view.addSubviews([title, divider1, mana, divider2, type, divider3, oracleText, divider4])
        
        title.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(10)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
        }
        
        divider1.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(DIVIDER_HEIGHT)
        }
        
        mana.snp.makeConstraints { make in
            make.top.equalTo(divider1.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
        }
        
        divider2.snp.makeConstraints { make in
            make.top.equalTo(mana.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(DIVIDER_HEIGHT)
        }

        type.snp.makeConstraints { make in
            make.top.equalTo(divider2.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
        }
        
        divider3.snp.makeConstraints { make in
            make.top.equalTo(type.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(DIVIDER_HEIGHT)
        }

        oracleText.snp.makeConstraints { make in
            make.top.equalTo(divider3.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
        }
        
        divider4.snp.makeConstraints { make in
            make.top.equalTo(oracleText.snp.bottom).offset(0)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom).offset(-10)
            make.height.equalTo(DIVIDER_HEIGHT)
        }
        
        return view
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
    }
}
