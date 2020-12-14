//
//  ASImageNode+Rx.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa

extension Reactive where Base: ASImageNode {

    public var image: ASBinder<UIImage?> {
        
        return ASBinder(self.base) { node, image in
            node.image = image
        }
    }
}
