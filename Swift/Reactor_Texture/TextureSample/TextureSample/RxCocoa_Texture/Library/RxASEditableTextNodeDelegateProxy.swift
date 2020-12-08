//
//  RxASEditableTextNodeDelegateProxy.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa

extension ASEditableTextNode: HasDelegate {
    public typealias Delegate = ASEditableTextNodeDelegate
}

open class RxASEditableTextNodeDelegateProxy
    : DelegateProxy<ASEditableTextNode, ASEditableTextNodeDelegate>
    , DelegateProxyType
    , ASEditableTextNodeDelegate {
    
    public weak private(set) var editableTextNode: ASEditableTextNode?
    
    public init(editableTextNode: ASEditableTextNode) {
        self.editableTextNode = editableTextNode
        super.init(parentObject: editableTextNode,
                   delegateProxy: RxASEditableTextNodeDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register { RxASEditableTextNodeDelegateProxy(editableTextNode: $0) }
    }
}
