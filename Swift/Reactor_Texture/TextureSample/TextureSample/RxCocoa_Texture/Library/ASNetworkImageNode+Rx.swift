//
//  ASNetworkImageNode+Rx.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa

extension Reactive where Base: ASNetworkImageNode {
    
    public var url: ASBinder<URL?> {
        
        return ASBinder(self.base) { node, url in
            node.setURL(url, resetToDefault: true)
        }
    }
    
    public func url(resetToDefault: Bool) -> ASBinder<URL?> {
        
        return ASBinder(self.base) { node, url in
            node.setURL(url, resetToDefault: resetToDefault)
        }
    }
}
