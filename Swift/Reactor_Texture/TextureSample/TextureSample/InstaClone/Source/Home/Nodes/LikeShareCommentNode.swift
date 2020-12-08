//
//  LikeShareCommentNode.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import AsyncDisplayKit

class LikeShareCommentNode: BaseNode {
    var likeButton = ASButtonNode()
    var commentButton = ASButtonNode()
    var shareButton = ASButtonNode()
    var numberOfLinkes = ASTextNode()
    var bookMark = ASButtonNode()
    var likeShareComment = LikeShareCommentInteractor()
    
    var likeCount: Int?
    
    override init() {
        super.init()
        setUp()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let hStackSingle = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .end, alignItems: .end, children: [bookMark])
        let singleStack = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8), child: hStackSingle)
        singleStack.style.flexGrow = 1
        
        let hStack = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [likeButton, commentButton, shareButton, singleStack])
        let padding = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 0), child: hStack)
        
        var dynamicLayout = [ASLayoutElement]()
        dynamicLayout.append(padding)
        let dynamicPadding = ASInsetLayoutSpec()
        if let count = likeCount, count > 0 {
            dynamicPadding.insets = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 0)
            dynamicPadding.child = numberOfLinkes
            dynamicLayout.append(dynamicPadding)
        }
        
        let vStack = ASStackLayoutSpec(direction: .vertical, spacing: 6, justifyContent: .start, alignItems: .stretch, children: dynamicLayout)
        return vStack
    }
    
    func populate(feed: NewsFeed?) {
//        print("\(feed?.user?.profileIcon)")
        let stringValue = feed?.likes == 1 ? "\(feed?.likes ?? 0)" : "\(feed?.likes ?? 0) likes"
        likeCount = feed?.likes ?? 0
        numberOfLinkes.attributedText = NSAttributedString(string: stringValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)])
    }
    
    override func asyncTraitCollectionDidChange(withPreviousTraitCollection previousTraitCollection: ASPrimitiveTraitCollection) {
        super.asyncTraitCollectionDidChange(withPreviousTraitCollection: previousTraitCollection)
        dynamicColours()
    }
    
    private func setUp() {
        likeButton.style.preferredSize = CGSize(width: 30, height: 30)
        commentButton.style.preferredSize = CGSize(width: 30, height: 30)
        shareButton.style.preferredSize = CGSize(width: 30, height: 30)
        dynamicColours()
    }
    
    private func dynamicColours() {
        if let colour = iconColour {
            likeButton.imageNode.imageModificationBlock = ASImageNodeTintColorModificationBlock(colour)
            likeButton.imageNode.image = UIImage(named: "like")
            likeButton.addTarget(likeShareComment, action: #selector(likeShareComment.postLike), forControlEvents: .touchUpInside)
            
            commentButton.imageNode.imageModificationBlock = ASImageNodeTintColorModificationBlock(colour)
            commentButton.imageNode.image = UIImage(named: "comment")
            
            shareButton.imageNode.imageModificationBlock = ASImageNodeTintColorModificationBlock(colour)
            shareButton.imageNode.image = UIImage(named: "share")
            
            bookMark.imageNode.imageModificationBlock = ASImageNodeTintColorModificationBlock(colour)
            bookMark.imageNode.image = UIImage(named: "bookmark")
        }
    }
}
