//
//  HomePresentation.swift
//  TextureSample
//
//  Created by sro on 2020/12/07.
//

import AsyncDisplayKit

class HomePresentation: BaseNode, ASTableDelegate {
    let table = ASTableNode()
    
    override init() {
        super.init()
        
        table.view.tableFooterView = UIView(frame: .zero)
        
        table.allowsSelection = false
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: table)
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        return ASSizeRangeMake(CGSize(width: width, height: 0), CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    }
}
