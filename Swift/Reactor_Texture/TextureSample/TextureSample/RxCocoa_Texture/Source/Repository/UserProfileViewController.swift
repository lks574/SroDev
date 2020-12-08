//
//  UserProfileViewController.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa

class UserProfileViewController: ASDKViewController<ASDisplayNode> {
    typealias Node = UserProfileViewController
    
    struct Const {
        static let placeHolderColor: UIColor = UIColor.gray.withAlphaComponent(0.2)
    }
    
    lazy var userProfileNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 100.0, height: 100.0)
        node.cornerRadius = 50.0
        node.clipsToBounds = true
        node.placeholderColor = Const.placeHolderColor
        node.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        node.borderWidth = 0.5
        return node
    }()
    
    lazy var usernameNode: ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.style.grow(1.0)
        node.attributedText = NSAttributedString(string: "Insert description", attributes: Node.usernamePlaceholderAttributes)
        node.typingAttributes = Node.convertTypingAttribute(Node.usernameAttributes)
        return node
    }()
    
    lazy var descriptionNode: ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.style.grow(1.0)
        node.attributedPlaceholderText = NSAttributedString(string: "Insert description", attributes: Node.descPlaceholderAttributes)
        node.typingAttributes = Node.convertTypingAttribute(Node.descAttributes)
        return node
    }()
    
    lazy var statusNode = { () -> ASTextNode in
        let node = ASTextNode()
        node.placeholderColor = Const.placeHolderColor
        return node
    }()
    
    let viewModel: RepositoryViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: RepositoryViewModel) {
        self.viewModel = viewModel
        super.init(node: ASDisplayNode())
        
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { [weak self] (_, _) -> ASLayoutSpec in
            guard let self = self else { return ASLayoutSpec() }
            self.userProfileNode.style.spacingAfter = 10.0
            self.usernameNode.style.spacingAfter = 30.0
            self.descriptionNode.style.spacingAfter = 10.0
            
            let profileStackLayout = ASStackLayoutSpec(direction: .vertical, spacing: 0.0, justifyContent: .center, alignItems: .center, children: [self.userProfileNode, self.usernameNode, self.descriptionNode, self.statusNode])
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 100.0, left: 15.0, bottom: .infinity, right: 15.0), child: profileStackLayout)
        }
        
        viewModel.profileURL.asObservable()
            .bind(to: userProfileNode.rx.url)
            .disposed(by: disposeBag)
        
        viewModel.username.asObservable()
            .bind(to: usernameNode.rx.text(Node.usernameAttributes), setNeedsLayout: node)
            .disposed(by: disposeBag)
        
        viewModel.desc.asObservable()
            .bind(to: descriptionNode.rx.text(Node.descAttributes), setNeedsLayout: node)
            .disposed(by: disposeBag)
        
        viewModel.status.asObservable()
            .bind(to: statusNode.rx.text(Node.statusAttributes), setNeedsLayout: node)
            .disposed(by: disposeBag)
        
        node.onDidLoad { [weak self] (_) in
            guard let self = self else { return }
            
            self.descriptionNode.textView.rx.text
                .throttle(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
                .bind(to: self.viewModel.updateDescription, setNeedsLayout: self.node)
                .disposed(by: self.disposeBag)
            
            self.usernameNode.textView.rx.text
                .throttle(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
                .bind(to: self.viewModel.updateUsername, setNeedsLayout: self.node)
                .disposed(by: self.disposeBag)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserProfileViewController {
    static var usernameAttributes: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)]
    }
    
    static var descAttributes: [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0),
                NSAttributedString.Key.paragraphStyle: paragraphStyle]
    }
    
    static var usernamePlaceholderAttributes: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)]
    }
    
    static var descPlaceholderAttributes: [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(0.5),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0),
                NSAttributedString.Key.paragraphStyle: paragraphStyle]
    }
    
    static var statusAttributes: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)]
    }
    
    static func convertTypingAttribute(_ attributes: [NSAttributedString.Key: Any]) -> [String: Any] {
        var typingAttribute: [String: Any] = [:]
        
        for key in attributes.keys {
            guard let attr = attributes[key] else { continue }
            typingAttribute[key.rawValue] = attr
        }
        
        return typingAttribute
    }
}
