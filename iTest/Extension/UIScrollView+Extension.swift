//
//  UIScrollView+Extension.swift
//  iTest
//
//  Created by 양성훈 on 2020/02/21.
//  Copyright © 2020 양성훈. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func resizeScrollViewContentSize() {
        
        var contentRect = CGRect.zero
        
        for view in self.subviews {
            
            contentRect = contentRect.union(view.frame)
            
        }
        
        self.contentSize = contentRect.size
        print("scrollV contentSize = \(self.contentSize)")
    }
    
}
