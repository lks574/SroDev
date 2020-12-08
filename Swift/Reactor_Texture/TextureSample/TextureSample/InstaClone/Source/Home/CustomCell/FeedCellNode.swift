//
//  FeedCellNode.swift
//  TextureSample
//
//  Created by sro on 2020/12/07.
//

import AsyncDisplayKit

class FeedCellNode: ASCellNode {
    var headerNode = HeaderNode()
    var imageFeedNode = FeedImageNode()
    var likeCommentNode = LikeShareCommentNode()
    var lastCommentNode = LastCommentNode()
    
    private var feed: NewsFeed?
    
    init(feed: NewsFeed?) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.feed = feed
        populate(feed: self.feed)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var layoutArray = [ASLayoutElement]()
        layoutArray.append(headerNode)
        layoutArray.append(imageFeedNode)
        if let likes = feed?.likes, likes > 0 {
            layoutArray.append(likeCommentNode)
        }
        
        if let lastComment = feed?.lastComment, lastComment.comment?.count ?? 0 > 0 {
            layoutArray.append(lastCommentNode)
        }
        
        let vStack = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: layoutArray)
        return vStack
    }
    
    private func populate(feed: NewsFeed?) {
        headerNode.populate(feed: feed)
        imageFeedNode.populate(feed: feed)
        likeCommentNode.populate(feed: feed)
        lastCommentNode.populate(feed: feed)
    }
}
