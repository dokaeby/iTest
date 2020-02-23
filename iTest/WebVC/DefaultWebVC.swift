//
//  DefaultWebVC.swift
//  iTest
//
//  Created by 양성훈 on 2020/02/22.
//  Copyright © 2020 양성훈. All rights reserved.
//

import UIKit
import WebKit
import Then
import SnapKit

class DefaultWebVC: UIViewController,
                    WKNavigationDelegate {
    
    // MARK:- UI property
    lazy var urlString:String = ""
    
    lazy var webView: WKWebView = WKWebView().then {
        $0.backgroundColor = .white
        $0.navigationDelegate = self
    }
    
    // MARK:- init
    // viewController init  ==================
    
    convenience init(url:String) {
        self.init(nibName: nil, bundle: nil)
//        guard let encodingUrlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
//        var encodingUrlString = url.stringByAddingPercentEncodingForFormData()
//        var encodingUrlString = url.removingPercentEncoding
        
        self.urlString = url
        print("urlString = \(urlString)")
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

        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
//        urlString = "https://www.apple.com"
        if let url = URL(string: urlString) {
            print("request url = \(url)")
            webView.load(URLRequest(url: url))
//            var req = NSURLRequest(url:url)

//            self.webView.loadRequest(req)
            webView.allowsBackForwardNavigationGestures = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
    func euckrEncoding(_ query: String) -> String { //EUC-KR 인코딩
        let rawEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.EUC_KR.rawValue))
        let encoding = String.Encoding(rawValue: rawEncoding)
        let eucKRStringData = query.data(using: encoding) ?? Data()
        let outputQuery = eucKRStringData.map {byte->String in
            if byte >= UInt8(ascii: "A") && byte <= UInt8(ascii: "Z") ||
               byte >= UInt8(ascii: "a") && byte <= UInt8(ascii: "z") ||
               byte >= UInt8(ascii: "0") && byte <= UInt8(ascii: "9") ||
               byte == UInt8(ascii: "_") || byte == UInt8(ascii: ".") ||
               byte == UInt8(ascii: "-") {
            return String(Character(UnicodeScalar(UInt32(byte))!)) }
        else if byte == UInt8(ascii: " ") { return "+" }
        else { return String(format: "%%%02X", byte) } }.joined()
        return outputQuery
    }

}
