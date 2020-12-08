//
//  RepositoryListCellNode.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa

class RepositoryListCellNode: ASCellNode {
    
    struct Const {
        static let placeHolderColor = UIColor.gray.withAlphaComponent(0.2)
        static var usernameAttributes: [NSAttributedString.Key: Any] {
            return [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)]
        }
        
        static var descAttributes: [NSAttributedString.Key: Any] {
            return [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]
        }
        
        static var statusAttributes: [NSAttributedString.Key: Any] {
            return [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)]
        }
        
        static var moreSeeAttributes: [NSAttributedString.Key: Any] {
            return [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0, weight: .medium)]
        }
    }
    
    // notes
    lazy var userProfileNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 50.0, height: 50.0)
        node.cornerRadius = 25.0
        node.clipsToBounds = true
        node.placeholderColor = Const.placeHolderColor
        node.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        node.borderWidth = 0.5
        return node
    }()
    
    lazy var usernameNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.placeholderColor = Const.placeHolderColor
        return node
    }()
    
    lazy var descriptionNode: ASTextNode = {
        let node = ASTextNode()
        node.placeholderColor = Const.placeHolderColor
        node.maximumNumberOfLines = 2
        node.truncationAttributedText = NSAttributedString(string: " ...More", attributes: Const.moreSeeAttributes)
        node.delegate = self
        node.isUserInteractionEnabled = true
        return node
    }()
    
    lazy var statusNode: ASTextNode = {
        let node = ASTextNode()
        node.placeholderColor = Const.placeHolderColor
        return node
    }()
    
    let disposeBag = DisposeBag()
    
    var id: Int = -1
    
    init(viewModel: RepositoryViewModel) {
        self.id = viewModel.id
        super.init()
        
        self.selectionStyle = .none
        self.backgroundColor = .white
        self.automaticallyManagesSubnodes = true
        
        viewModel.profileURL
            .bind(to: userProfileNode.rx.url)
            .disposed(by: disposeBag)
        
        viewModel.username
            .bind(to: usernameNode.rx.text(Const.usernameAttributes), setNeedsLayout: self)
            .disposed(by: disposeBag)
        
        viewModel.desc
            .bind(to: descriptionNode.rx.text(Const.descAttributes), setNeedsLayout: self)
            .disposed(by: disposeBag)
        
        viewModel.status
            .bind(to: statusNode.rx.text(Const.statusAttributes), setNeedsLayout: self)
            .disposed(by: disposeBag)
        
        userProfileNode.rx
            .tap(to: viewModel.openProfileRelay)
            .disposed(by: disposeBag)
    }
}


extension RepositoryListCellNode: ASTextNodeDelegate {
    func textNodeTappedTruncationToken(_ textNode: ASTextNode!) {
        textNode.maximumNumberOfLines = 0
        self.recursivelyEnsureDisplaySynchronously(true)    // TODO: Check
        self.setNeedsLayout()
    }
}

// MARK: - LayoutSpec
extension RepositoryListCellNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = contentLayoutSpec()
        contentLayout.style.shrink(1.0).grow(1.0)
        userProfileNode.style.shrink(1.0).grow(0.0)
        
        let stackLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 10.0, justifyContent: .start, alignItems: .center, children: [userProfileNode, contentLayout])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0), child: stackLayout)
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        let elements = [self.usernameNode, self.descriptionNode, self.statusNode].filter { $0.attributedText?.length ?? 0 > 0 }
        return ASStackLayoutSpec(direction: .vertical, spacing: 5.0, justifyContent: .start, alignItems: .stretch, children: elements)
    }
}
