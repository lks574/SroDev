//
//  HeaderNode.swift
//  TextureSample
//
//  Created by sro on 2020/12/07.
//

import AsyncDisplayKit

class HeaderNode: BaseNode {
    
    var profileImageNode = ASNetworkImageNode()
    var nameNode = ASTextNode()
    var extraButton = ASButtonNode()
    var elipseNode = ASImageNode()
    
    override init() {
        super.init()
        setUp()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let leftPadding = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 0), child: profileImageNode)
        let iconSpec = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .end, alignItems: .end, children: [extraButton])
        let rightPadding = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16), child: iconSpec)
        rightPadding.style.flexGrow = 1
        
        let layoutSpec = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [leftPadding, nameNode, rightPadding])
        return layoutSpec
    }
    
    private func setUp() {
        let cornerRadius: CGFloat = 35.0
        profileImageNode.cornerRoundingType = .precomposited
        profileImageNode.cornerRadius = cornerRadius / 2
        profileImageNode.style.preferredSize = CGSize(width: 35, height: 35)
        dynamicColour()
        extraButton.style.preferredSize = CGSize(width: 10, height: 10)
    }
    
    private func dynamicColour() {
        if let colour = iconColour {
            extraButton.imageNode.imageModificationBlock = ASImageNodeTintColorModificationBlock(colour)
            extraButton.imageNode.image = UIImage(named: "elipse")
        }
    }
    
    public func populate(feed: NewsFeed?) {
        nameNode.attributedText = NSAttributedString(string: feed?.user?.username ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.label, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        profileImageNode.url = URL(string: feed?.user?.profileIcon ?? "")
    }
}
