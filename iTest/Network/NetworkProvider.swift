//
//  NetworkProvider.swift
//  iTest
//
//  Created by 양성훈 on 2020/02/23.
//  Copyright © 2020 양성훈. All rights reserved.
//

import Foundation
import Alamofire

class NetworkProvider {
    
    static let SI = NetworkProvider()
    
    func requestContentsData(_ url:String = "", completion: @escaping([iTunesSearchResult]?) -> Void) {
        
        Alamofire.request(url)
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    // json decodable
                    if let json = response.result.value as? [String: Any], let tracks = json["results"] as? Array<[String: Any]>, tracks.count > 0 {
                        let jsonData = try? JSONSerialization.data(withJSONObject: tracks, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)
                        let data = jsonString?.data(using: .utf8)!
                        do {
                            let dataList = try! JSONDecoder().decode([iTunesSearchResult].self, from: data!)
                            completion(dataList)
                        }
                    }
                    
                case .failure(_):
                    completion(nil)
                    return
                }
        }
        
    }

}
