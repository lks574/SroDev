//
//  ASControlTarget.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa

// This should be only used from `MainScheduler`
final class ASControlTarget<Control: ASControlNode>: _RXKVOObserver, Disposable {
    
    typealias Callback = (Control) -> Void
    
    let selector = #selector(eventHandler(_:))
    
    weak var controlNode: Control?
    let controlEvents: ASControlNodeEvent
    var callback: Callback?
    
    init(_ controlNode: Control,
         _ controlEvents: ASControlNodeEvent,
         callback: @escaping Callback) {
        
        self.controlNode = controlNode
        self.controlEvents = controlEvents
        self.callback = callback
        
        super.init()
        
        controlNode.addTarget(self,
                              action: selector,
                              forControlEvents: controlEvents)
        
        let method = self.method(for: selector)
        if method == nil {
            fatalError("Can't find method")
        }
    }
    
    @objc func eventHandler(_ sender: UIGestureRecognizer) {
        
        if let callback = self.callback, let controlNode = self.controlNode {
            callback(controlNode)
        }
    }
    
    override func dispose() {
        
        super.dispose()
        self.controlNode?.removeTarget(self,
                                       action: selector,
                                       forControlEvents: .allEvents)
        self.callback = nil
    }
}
