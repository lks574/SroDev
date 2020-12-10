//
//  ReactorKitEx.swift
//  TextureSample
//
//  Created by sro on 2020/12/10.
//

import AsyncDisplayKit
import ReactorKit

// https://github.com/GeekTree0101/ReactorKit-Texture-Best-Practice
class SignUpNodeController: ASDKViewController<SignUpContainerNode> {
    
    override init() {
        super.init(node: SignUpContainerNode())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
