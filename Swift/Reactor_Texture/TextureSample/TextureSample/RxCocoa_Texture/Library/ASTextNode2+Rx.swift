//
//  ASTextNode2+Rx.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa

#if (!AS_ENABLE_TEXTNODE)

extension Reactive where Base: ASTextNode2 {
    
    public var attributedText: ASBinder<NSAttributedString?> {
        
        return ASBinder(self.base) { node, attributedText in
            node.attributedText = attributedText
        }
    }
    
    public func text(_ attributes: [NSAttributedString.Key: Any]?) -> ASBinder<String?> {
        
        return ASBinder(self.base) { node, text in
            guard let text = text else {
                node.attributedText = nil
                return
            }
            
            node.attributedText = NSAttributedString(string: text,
                                                     attributes: attributes)
        }
    }
}

#endif
