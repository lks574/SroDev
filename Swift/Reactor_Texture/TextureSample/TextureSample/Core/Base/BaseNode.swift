//
//  BaseNode.swift
//  TextureSample
//
//  Created by sro on 2020/12/07.
//

import AsyncDisplayKit

class BaseNode: ASDisplayNode {
    
    override init() {
        super.init()
        
        self.automaticallyManagesSubnodes = true
    }
}
