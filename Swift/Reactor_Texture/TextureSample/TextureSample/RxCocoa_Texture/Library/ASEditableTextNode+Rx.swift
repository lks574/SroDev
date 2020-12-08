//
//  ASEditableTextNode+Rx.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa

extension Reactive where Base: ASEditableTextNode {
    
    public var delegate: DelegateProxy<ASEditableTextNode, ASEditableTextNodeDelegate> {
        return RxASEditableTextNodeDelegateProxy.proxy(for: base)
    }
    
    public var attributedText: ControlProperty<NSAttributedString?> {
        
        let source: Observable<NSAttributedString?> = Observable.deferred { [weak editableTextNode = self.base] in
            let attrText = editableTextNode?.attributedText
            
            let textChanged: Observable<NSAttributedString?> = editableTextNode?.rx.delegate.methodInvoked(#selector(ASEditableTextNodeDelegate.editableTextNodeDidUpdateText(_:)))
                .observeOn(MainScheduler.asyncInstance)
                .map { _ in
                    return editableTextNode?.attributedText
                }
                ?? .empty()
            
            return textChanged.startWith(attrText)
        }
        
        let bindingObserver = ASBinder(self.base) { node, attributedText in
            node.attributedText = attributedText
        }
        
        return ControlProperty(values: source, valueSink: bindingObserver)
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

