//
//  ASLayoutElementStyle+Rx.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import AsyncDisplayKit

extension ASLayoutElementStyle {
    
    @discardableResult
    func shrink(_ scale: CGFloat) -> ASLayoutElementStyle {
        self.flexShrink = scale
        return self
    }
    
    @discardableResult
    func grow(_ scale: CGFloat) -> ASLayoutElementStyle {
        self.flexGrow = scale
        return self
    }
    
    @discardableResult
    func nonShrink() -> ASLayoutElementStyle {
        self.flexShrink = 0.0
        return self
    }
    
    @discardableResult
    func nonGrow() -> ASLayoutElementStyle {
        self.flexGrow = 0.0
        return self
    }
    
    @discardableResult
    func height(_ scale: ASDimension) -> ASLayoutElementStyle {
        self.height = scale
        return self
    }

    @discardableResult
    func widht(_ scale: ASDimension) -> ASLayoutElementStyle {
        self.width = scale
        return self
    }
}
