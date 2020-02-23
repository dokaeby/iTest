//
//  MainTableViewCell.swift
//  Backpac_test
//
//  Created by 양성훈 on 2020/02/19.
//  Copyright © 2020 양성훈. All rights reserved.
//

import UIKit
import Kingfisher
import Then
import Cosmos

final class MainTableViewCell: UITableViewCell {
    
    //MARK:- Constant
    
    static var CellIdentifier: String { return String(describing: self) }
    
//    private(set) var disposeBag = DisposeBag()
    
    private struct UI {
        static let basicMargin: CGFloat = 10
        static let width:CGFloat = UIScreen.main.bounds.size.width - 20
        static let height:CGFloat = UIScreen.main.bounds.size.width - 20
    }
    
    var cellData:iTunesSearchResult!
    //MAKR:- UI Properties

    lazy var backView:UIView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    lazy var appImageV: UIImageView = UIImageView().then {
        $0.backgroundColor = UIColor.white
    }
    
    lazy var appNameLabelV: UILabel = UILabel().then {
        $0.textColor = UIColor.black
    }
    
    lazy var corporationNameLabelV: UILabel = UILabel().then {
        $0.textColor = UIColor.lightGray
    }

    lazy var separatorLineV: UIView = UIView().then {
        $0.backgroundColor = UIColor.lightGray
    }

    lazy var categoryLabelV: UILabel = UILabel().then {
        $0.textColor = UIColor.black
    }
    
    lazy var priceLabelV: UILabel = UILabel().then {
        $0.textColor = UIColor.lightGray
    }

    lazy var starRatingV:CosmosView = CosmosView().then {
        $0.isHidden = false
    }
    //MARK:- Properties
    
    
    //MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.lightGray
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        
        contentView.addSubview(backView)
        
        [ appImageV, appNameLabelV, corporationNameLabelV,
          separatorLineV, categoryLabelV, priceLabelV,
          starRatingV ].forEach { backView.addSubview($0) }
                
        backView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(UI.basicMargin)
            $0.left.equalTo(contentView.snp.left).offset(UI.basicMargin)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-UI.basicMargin)
            $0.right.equalTo(contentView.snp.right).offset(-UI.basicMargin)
        }
        // app Image
        appImageV.snp.makeConstraints {
            $0.top.equalTo(backView.snp.top)
            $0.left.equalTo(backView.snp.left)
            $0.right.equalTo(backView.snp.right)
            $0.height.equalTo(UI.height)
        }
        
        // app Name
        appNameLabelV.snp.makeConstraints {
            $0.top.equalTo(appImageV.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(backView.snp.left).offset(UI.basicMargin)
        }
        
        // corporation Name
        corporationNameLabelV.snp.makeConstraints {
            $0.top.equalTo(appNameLabelV.snp.bottom).offset(UI.basicMargin / 2)
            $0.left.equalTo(backView.snp.left).offset(UI.basicMargin )
        }
        
        // separatorLine
        separatorLineV.snp.makeConstraints {
            $0.top.equalTo(corporationNameLabelV.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(backView.snp.left).offset(UI.basicMargin )
            $0.right.equalTo(backView.snp.right).offset(-UI.basicMargin )
            $0.height.equalTo(1)
        }
        
        // category
        categoryLabelV.snp.makeConstraints {
            $0.top.equalTo(separatorLineV.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(backView.snp.left).offset(UI.basicMargin )
        }
        
        // price
        priceLabelV.snp.makeConstraints {
            $0.top.equalTo(categoryLabelV.snp.bottom).offset(UI.basicMargin / 2)
            $0.left.equalTo(backView.snp.left).offset(UI.basicMargin)
        }
        
        // star rating V
        starRatingV.snp.makeConstraints {
            $0.top.equalTo(separatorLineV.snp.bottom).offset(UI.basicMargin)
            $0.right.equalTo(backView.snp.right).offset(-UI.basicMargin)
        }

    }
    
    func configure(_ data: iTunesSearchResult) {
        
        weak var ws = self
        
        cellData = data
        
        appImageV.kf.setImage(with: URL(string:(cellData.artworkUrl512)!))
        appNameLabelV.text = cellData.trackCensoredName
        corporationNameLabelV.text = cellData.sellerName
        if !cellData.genres.isEmpty {
            categoryLabelV.text = cellData.genres.last as! String
        }
        priceLabelV.text = cellData.formattedPrice
        starRatingV.rating = Double(cellData.averageUserRating)
    }
    
    override public func prepareForReuse() {
        // Ensures the reused cosmos view is as good as new
        starRatingV.prepareForReuse()
    }
}

