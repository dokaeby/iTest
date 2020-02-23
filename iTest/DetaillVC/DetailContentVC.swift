//
//  DetailContentVC.swift
//  iTest
//
//  Created by 양성훈 on 2020/02/21.
//  Copyright © 2020 양성훈. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SnapKit
import Then
import Alamofire

class DetailContentVC: UIViewController {
    
    private struct UI {
        static let basicMargin: CGFloat = 10
        static let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        static let screenShotWidth:CGFloat = UIScreen.main.bounds.size.width / 5 * 3
        static let screenShotHeight:CGFloat = UIScreen.main.bounds.size.width
        static let separatorHeight:CGFloat = 1
    }

    //MARK:- Properties
    var data:iTunesSearchResult!
    lazy var dataList:[iTunesSearchResult] = []
    lazy var categoryList:[HashTag] = []
    
    lazy var disposeBag = DisposeBag()
    //MARK:- UI Properties
    
    lazy var separator0V:UIView = UIView().then {
        $0.backgroundColor = UIColor.lightGray
    }

    lazy var vScrollV: UIScrollView = UIScrollView().then {
        $0.backgroundColor = UIColor.white
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }

    lazy var hScrollV: UIScrollView = UIScrollView().then {
        $0.backgroundColor = UIColor.white
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }

    lazy var screenStackV:UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.spacing = 10
        $0.isUserInteractionEnabled = false
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.isHidden = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    lazy var appNameLabelV: UILabel = UILabel().then {
        $0.textColor = UIColor.black
    }
    
    lazy var corporationNameLabelV: UILabel = UILabel().then {
        $0.textColor = UIColor.gray
    }

    lazy var priceLabelV: UILabel = UILabel().then {
        $0.textColor = UIColor.gray
    }
    
    lazy var webButtonV:UIButton = UIButton().then {
        $0.setTitle("웹에서 보기", for: .normal)
        $0.setTitleColor(UIColor.gray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.isUserInteractionEnabled = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.isExclusiveTouch = true
    }
    
    lazy var shareButtonV:UIButton = UIButton().then {
        $0.setTitle("공유하기", for: .normal)
        $0.setTitleColor(UIColor.gray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.isUserInteractionEnabled = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.isExclusiveTouch = true
    }
    
    lazy var separator1V:UIView = UIView().then {
        $0.backgroundColor = UIColor.lightGray
    }

    lazy var sizeTitleLabelV: UILabel = UILabel().then {
        $0.text = "크기"
        $0.textColor = UIColor.gray
    }
    
    lazy var sizeLabelV: UILabel = UILabel().then {
        $0.textColor = UIColor.blue.withAlphaComponent(0.7)
    }
    
    lazy var separator2V:UIView = UIView().then {
        $0.backgroundColor = UIColor.lightGray
    }
    
    lazy var ageTitleLabelV: UILabel = UILabel().then {
        $0.text = "연령"
        $0.textColor = UIColor.gray
    }
    
    lazy var ageLabelV: UILabel = UILabel().then {
        $0.textColor = UIColor.blue.withAlphaComponent(0.7)
    }
    
    lazy var separator3V:UIView = UIView().then {
        $0.backgroundColor = UIColor.lightGray
    }
    
    lazy var newFuncContainerV:UIView = UIView().then {
        $0.isUserInteractionEnabled = true
    }
    
    lazy var newFuncTitleLabelV: UILabel = UILabel().then {
        $0.text = "새로운 기능"
        $0.textColor = UIColor.gray
    }
    
    lazy var newFuncLabelV: UILabel = UILabel().then {
        $0.textColor = UIColor.blue.withAlphaComponent(0.7)
    }

    lazy var newFuncImageV: UIImageView = UIImageView().then {
        $0.isHidden = false
        $0.image = UIImage(named:"icoGroupfoldDown20X20")
    }

    lazy var newFuncContentLabelV: UILabel = UILabel().then {
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        $0.textColor = UIColor.gray
        $0.isHidden = true
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    lazy var separator4V:UIView = UIView().then {
        $0.backgroundColor = UIColor.lightGray
    }
    
    lazy var descriptionLabelV: UILabel = UILabel().then {
        $0.backgroundColor = UIColor.white
        $0.textColor = UIColor.gray
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    lazy var separator5V:UIView = UIView().then {
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    }
    
    lazy var categoryTitleLabelV: UILabel = UILabel().then {
        $0.text = "카테고리"
        $0.textColor = UIColor.black
    }

    lazy var categoryContentV: HashtagView = HashtagView().then {
        $0.tagBackgroundColor = UIColor.white
        $0.tagTextColor = UIColor.lightGray
        $0.tagCornerRadius = 5.0
        $0.clipsToBounds = true
    }
    
    lazy var separator6V:UIView = UIView().then {
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    }
    
    // MARK:- init
    // viewController init  ==================
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Initialize properties of class
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        [separator0V, vScrollV ].forEach { view.addSubview($0) }
        
        [hScrollV, appNameLabelV, corporationNameLabelV, priceLabelV,
         webButtonV, shareButtonV, separator1V, sizeTitleLabelV, sizeLabelV,
         separator2V, ageTitleLabelV, ageLabelV, separator3V, newFuncContainerV,
         newFuncContentLabelV, separator4V, descriptionLabelV, separator5V,
         categoryTitleLabelV, categoryContentV, separator6V  ].forEach { vScrollV.addSubview($0)
        }
        
        hScrollV.addSubview(screenStackV)
        
        [newFuncTitleLabelV, newFuncLabelV, newFuncImageV, newFuncContentLabelV,
         separator4V ].forEach { newFuncContainerV.addSubview($0) }
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let backButton = UIBarButtonItem()
        backButton.title = "핸드메이드"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        setupUIEventBinding()
    }
    
    override func viewDidLayoutSubviews() {
        
        vScrollV.resizeScrollViewContentSize()
        hScrollV.resizeScrollViewContentSize()

    }
    
    func setupLayout() -> Void {

        separator0V.snp.makeConstraints {
            if #available(iOS 11.0, *) {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            } else {
                $0.top.equalToSuperview().offset(UI.basicMargin * 2)
            }
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        // vScrollV
        vScrollV.snp.makeConstraints {
            $0.top.equalTo(separator0V.snp.bottom).offset(UI.basicMargin * 4.5)
            $0.leading.trailing.equalTo(self.view)
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                $0.bottom.equalToSuperview()
            }
        }
        // hScrollV
        hScrollV.snp.makeConstraints {
            $0.top.equalTo(vScrollV.snp.top)
            $0.leading.trailing.equalTo(self.view)
            $0.height.equalTo(UI.screenWidth)
        }
        // screenStackV
        screenStackV.snp.makeConstraints {
            $0.top.equalTo(hScrollV.snp.top)
            $0.leading.trailing.equalTo(hScrollV)
            $0.height.equalTo(UI.screenWidth)
        }

        // app Name
        appNameLabelV.snp.makeConstraints {
            $0.top.equalTo(vScrollV.snp.top).offset(UI.screenWidth + UI.basicMargin)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin)
        }

        // corporation Name
        corporationNameLabelV.snp.makeConstraints {
            $0.top.equalTo(appNameLabelV.snp.bottom).offset(UI.basicMargin / 2)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin )
        }
        // priceLabelV Name
        priceLabelV.snp.makeConstraints {
            $0.top.equalTo(corporationNameLabelV.snp.bottom).offset(UI.basicMargin / 2)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin )
        }

        webButtonV.snp.makeConstraints {
            $0.top.equalTo(priceLabelV.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin)
            $0.right.equalTo(view.snp.centerX)
            $0.height.equalTo(40)
        }

        shareButtonV.snp.makeConstraints {
            $0.top.equalTo(priceLabelV.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(webButtonV.snp.right).offset(-1)
            $0.width.equalTo(webButtonV.snp.width)
            $0.height.equalTo(40)
        }

        separator1V.snp.makeConstraints {
            $0.top.equalTo(webButtonV.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin )
            $0.right.equalTo(view.snp.right).offset(-UI.basicMargin )
            $0.height.equalTo(UI.separatorHeight)
        }

        // corporation Name
        sizeTitleLabelV.snp.makeConstraints {
            $0.top.equalTo(separator1V.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin )
        }
        // priceLabelV Name
        sizeLabelV.snp.makeConstraints {
            $0.top.equalTo(separator1V.snp.bottom).offset(UI.basicMargin)
            $0.right.equalTo(view.snp.right).offset(-UI.basicMargin )
        }

        separator2V.snp.makeConstraints {
            $0.top.equalTo(sizeTitleLabelV.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin )
            $0.right.equalTo(view.snp.right).offset(-UI.basicMargin )
            $0.height.equalTo(UI.separatorHeight)
        }

        // ageTitleLabelV
        ageTitleLabelV.snp.makeConstraints {
            $0.top.equalTo(separator2V.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin )
        }
        // ageLabelV
        ageLabelV.snp.makeConstraints {
            $0.top.equalTo(separator2V.snp.bottom).offset(UI.basicMargin)
            $0.right.equalTo(view.snp.right).offset(-UI.basicMargin )
        }

        separator3V.snp.makeConstraints {
            $0.top.equalTo(ageTitleLabelV.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin )
            $0.right.equalTo(view.snp.right).offset(-UI.basicMargin )
            $0.height.equalTo(UI.separatorHeight)
        }

        newFuncContainerV.snp.makeConstraints {
            $0.top.equalTo(separator3V.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin )
            $0.right.equalTo(view.snp.right).offset(-UI.basicMargin )
            $0.height.equalTo(30)
        }

        newFuncTitleLabelV.snp.makeConstraints {
            $0.top.equalTo(newFuncContainerV.snp.top)
            $0.left.equalTo(newFuncContainerV.snp.left)
        }

        newFuncImageV.snp.makeConstraints {
            $0.top.equalTo(newFuncContainerV.snp.top)
            $0.right.equalTo(newFuncContainerV.snp.right)
        }

        newFuncLabelV.snp.makeConstraints {
            $0.top.equalTo(newFuncContainerV.snp.top)
            $0.right.equalTo(newFuncImageV.snp.left).offset(-UI.basicMargin / 2)
        }

        separator4V.snp.makeConstraints {
            $0.top.equalTo(newFuncTitleLabelV.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(newFuncContainerV.snp.left)
            $0.right.equalTo(newFuncContainerV.snp.right)
            $0.height.equalTo(UI.separatorHeight)
        }

        newFuncContentLabelV.snp.makeConstraints {
            $0.top.equalTo(newFuncTitleLabelV.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(newFuncContainerV.snp.left)
            $0.right.equalTo(newFuncContainerV.snp.right)
        }

        descriptionLabelV.snp.makeConstraints {
            $0.top.equalTo(newFuncContainerV.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin)
            $0.right.equalTo(view.snp.right).offset(-UI.basicMargin)
        }

        separator5V.snp.makeConstraints {
            $0.top.equalTo(descriptionLabelV.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin)
            $0.right.equalTo(view.snp.right).offset(-UI.basicMargin)
            $0.height.equalTo(15)
        }

        categoryTitleLabelV.snp.makeConstraints {
            $0.top.equalTo(separator5V.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin * 2)
            $0.right.equalTo(view.snp.right).offset(-UI.basicMargin)
        }

        categoryContentV.snp.makeConstraints {
            $0.top.equalTo(categoryTitleLabelV.snp.bottom).offset(UI.basicMargin)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin)
            $0.right.equalTo(view.snp.right)
        }

        separator6V.snp.makeConstraints {
            $0.top.equalTo(categoryContentV.snp.bottom).offset(-UI.basicMargin)
            $0.left.equalTo(view.snp.left).offset(UI.basicMargin)
            $0.right.equalTo(view.snp.right).offset(-UI.basicMargin)
            $0.height.equalTo(15)
        }
    }
    
    func configure(data:iTunesSearchResult) -> Void {
        
        self.data = data
        
        for url in data.screenshotUrls {
            let imageV:UIImageView = UIImageView()
            imageV.kf.setImage(with: URL(string:(url!)))
            
            screenStackV.addArrangedSubview(imageV)
            
            imageV.snp.makeConstraints {
                $0.top.equalTo(screenStackV.snp.top).offset(UI.basicMargin)
                $0.width.equalTo(UI.screenShotWidth)
                $0.height.equalTo(UI.screenWidth - UI.basicMargin * 2)
            }
        }

        appNameLabelV.text = data.trackCensoredName
        corporationNameLabelV.text = data.sellerName
        
        if (data.formattedPrice?.hasPrefix("￦"))! {
            
            let tempStr = data.formattedPrice
            let str = tempStr?.subString(from:1, to:tempStr!.count - 1)
            
            let priceString = NSAttributedString(string: str!, attributes: [.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.black])
            let currenyString = NSAttributedString(string: "원", attributes: [.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.black])
            let attrString = NSMutableAttributedString()
            attrString.append(priceString)
            attrString.append(currenyString)
            priceLabelV.attributedText = attrString
        } else {
            priceLabelV.text = data.formattedPrice
        }
        // file size display MB
        if let fileSize = data.fileSizeBytes {
            let size = Int64(fileSize)! / Int64(1048576) //Convert in to MB
            sizeLabelV.text = String(size) + "MB"
        }

        ageLabelV.text = data.trackContentRating
        newFuncLabelV.text = data.version
        newFuncContentLabelV.text = data.releaseNotes
        descriptionLabelV.text = data.description
        // category
        let categorydata = data.genres
        for data in categorydata {
            let tag = HashTag(word: data!)
            categoryList.append(tag)
        }
        categoryContentV.addTags(tags: categoryList)
        
    }
    
    func setupUIEventBinding() -> Void {
        
        weak var ws = self
        
        webButtonV.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { gesture in

                gesture.cancelsTouchesInView = false
                print("trackViewUrl = \(ws!.data.trackViewUrl!)")
                let vc = DefaultWebVC(url:ws!.data.trackViewUrl!)
                ws?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
        
        shareButtonV.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { gesture in
                
                gesture.cancelsTouchesInView = false
                
                let activityViewController = UIActivityViewController(activityItems:  [ws?.data.trackViewUrl!], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = ws!.view
                activityViewController.completionWithItemsHandler = { activity, success, items, error in
                    
                }
                
                ws?.navigationController?.present(activityViewController, animated: true, completion: {
                   
                })
            }).disposed(by: disposeBag)
        
        newFuncContainerV.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { gesture in
                
                gesture.cancelsTouchesInView = false
                
                ws?.newFuncContentLabelV.isHidden = !(ws?.newFuncContentLabelV.isHidden)!
                
                ws?.setViewAnimation(view: ws!.newFuncContentLabelV, hidden: (ws?.newFuncContentLabelV.isHidden)!)
                
                
            }).disposed(by: disposeBag)
    }
    
    func setViewAnimation(view: UIView, hidden: Bool) {
        
        weak var ws = self
        
        UIView.transition(with: view, duration: 0.3, options: .curveEaseIn, animations: {
            
            view.isHidden = hidden
            
            let isViewHidden = (ws?.newFuncContentLabelV.isHidden)!
            
            if isViewHidden {
                ws!.newFuncImageV.rotate(isViewHidden ? 0.0 : .pi )
                ws!.newFuncContainerV.snp.remakeConstraints {
                    $0.top.equalTo(ws!.separator3V.snp.bottom).offset(UI.basicMargin)
                    $0.left.equalTo(ws!.view.snp.left).offset(UI.basicMargin )
                    $0.right.equalTo(ws!.view.snp.right).offset(-UI.basicMargin )
                    $0.height.equalTo(30)
                }
            } else {
                ws!.newFuncImageV.rotate(isViewHidden ? 0.0 : .pi )
                let height = ws!.newFuncContentLabelV.numberOfVisibleLines * 22
                
                ws!.newFuncContainerV.snp.remakeConstraints {
                    $0.top.equalTo(ws!.separator3V.snp.bottom).offset(UI.basicMargin)
                    $0.left.equalTo(ws!.view.snp.left).offset(UI.basicMargin )
                    $0.right.equalTo(ws!.view.snp.right).offset(-UI.basicMargin )
                    $0.height.equalTo(height)
                }
            }
            self.view.layoutIfNeeded()
        })
    }
    
}

