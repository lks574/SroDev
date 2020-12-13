//
//  SignUpContainerNode.swift
//  TextureSample
//
//  Created by sro on 2020/12/10.
//

import AsyncDisplayKit
import ReactorKit
import RxSwift
import RxKeyboard

class SignUpContainerNode: ASDisplayNode {
    struct Const {
        static let containerInserts: UIEdgeInsets = .init(top: 0.0, left: 30.0, bottom: 0.0, right: 30.0)
        static let signupButtonHeight: ASDimension = .init(unit: .points, value: 50.0)
        static let inputFieldSpacing: CGFloat = 20.0
        static let signUpButtonInsets: UIEdgeInsets = .init(top: 30.0, left: 10.0, bottom: 0.0, right: 10.0)
    }
    
    private let emailInputNode = SignUpFieldNode(scope: .email)
    private let passwordInpuNode = SignUpFieldNode(scope: .password)
    
    private let signUpButtonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.style.height = Const.signupButtonHeight
        node.setBackgroundImage(UIImage.backgroundImage(color: .blue), for: .normal)
        node.setBackgroundImage(UIImage.backgroundImage(color: .gray), for: .disabled)
        node.setTitle("Sign Up", with: UIFont.boldSystemFont(ofSize: 15.0), with: .white, for: .normal)
        node.setTitle("Sign Up", with: UIFont.boldSystemFont(ofSize: 15.0), with: .white, for: .disabled)
        node.cornerRadius = 5.0
        node.clipsToBounds = true
        node.isEnabled = false
        return node
    }()
    
    private let keyboardDismissEventNode = ASControlNode()
    
    private var keyboardVisibleHeight: CGFloat = 0.0
    
    var disposeBag = DisposeBag()
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.backgroundColor = .white
        self.observeKeyboard()
    }
    
    private func observeKeyboard() {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] height in
                self?.keyboardVisibleHeight = height
                self?.transitionLayout(withAnimation: true, shouldMeasureAsync: false, measurementCompletion: nil)
            }).disposed(by: disposeBag)
        
        keyboardDismissEventNode.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.emailInputNode.textView?.endEditing(true)
                self?.passwordInpuNode.textView?.endEditing(true)
            }).disposed(by: disposeBag)
    }
    
    private func observeInputField() {
        guard let emailValidObservable = emailInputNode.reactor?.state.map({ $0.fieldStatus == .valid }),
              let passwordValidObservable = passwordInpuNode.reactor?.state.map({ $0.fieldStatus == .valid }) else { return }
        
        Observable.combineLatest(emailValidObservable, passwordValidObservable) { ($0 , $1)}
            .map { $0 && $1 }
            .bind(to: signUpButtonNode.rx.isEnabled)
            .disposed(by: disposeBag)
        
        guard let emailInputTextView = emailInputNode.textView,
              let passwordInputTextView = passwordInpuNode.textView else { return }
        
        
        emailInputTextView.rx.controlEvent([.editingDidEndOnExit, .editingDidEnd])
            .withLatestFrom(passwordInputTextView.rx.text)
            .filter { $0?.isEmpty ?? false }
            .subscribe(onNext: { [weak self] _ in
                self?.passwordInpuNode.textView?.becomeFirstResponder()
            }).disposed(by: disposeBag)
    }
}

extension SignUpContainerNode {
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let flexsibleTopLayout = ASLayoutSpec()
        flexsibleTopLayout.style.grow(1.0)
        
        let flexsibleBottomLayout = ASLayoutSpec()
        flexsibleBottomLayout.style.flexGrow = 1.0
        
        let keyboardFlexLayout = ASLayoutSpec()
        keyboardFlexLayout.style.height = .init(unit: .points, value: keyboardVisibleHeight)
        
        let containerLayout = ASStackLayoutSpec(direction: .vertical, spacing: 0.0, justifyContent: .start, alignItems: .stretch, children: [flexsibleTopLayout, self.inputFieldAreaLayoutSpec(), self.signUpButtonLayoutSpec(), flexsibleBottomLayout, keyboardFlexLayout])
        
        let touchabelContainerLayout = ASOverlayLayoutSpec(child: keyboardDismissEventNode, overlay: containerLayout)
        return ASInsetLayoutSpec(insets: Const.containerInserts, child: touchabelContainerLayout)
    }
    
    private func inputFieldAreaLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: Const.inputFieldSpacing, justifyContent: .start, alignItems: .stretch, children: [emailInputNode, passwordInpuNode])
    }
    
    private func signUpButtonLayoutSpec() -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: Const.signUpButtonInsets, child: signUpButtonNode)
    }
}


extension UIImage {
    
    class func backgroundImage(color: UIColor, size: CGSize = .init(width: 1, height: 1)) -> UIImage? {
        var rect: CGRect = .zero
        rect.size = size
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
