//
//  HomeViewController.swift
//  TextureSample
//
//  Created by sro on 2020/12/07.
//

import AsyncDisplayKit

class HomeViewController: ASDKViewController<BaseNode> {
    
    var newsFeed: BaseNode!
    
    override init() {
        super.init(node: BaseNode())
        self.node.backgroundColor = .white
        
        self.node.addSubnode(newsFeed)
        node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .zero, child: self.newsFeed)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "InstaClone"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
