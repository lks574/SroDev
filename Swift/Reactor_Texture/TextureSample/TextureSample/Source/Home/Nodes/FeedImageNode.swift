//
//  FeedImageNode.swift
//  TextureSample
//
//  Created by sro on 2020/12/07.
//

import AsyncDisplayKit

class FeedImageNode: BaseNode {
    var imageNode = ASNetworkImageNode()
    
    override init() {
        super.init()
        imageNode.style.preferredSize.width = UIScreen.main.bounds.width
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let standardSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: imageNode)
        return standardSpec
    }
    
    func populate(feed: NewsFeed?) {
        imageNode.url = URL(string: feed?.imageUrl ?? "")
        imageNode.style.preferredSize.height = UIScreen.main.bounds.width * CGFloat(feed?.aspectRatio ?? 1.0)
    }
}
