//
//  UserProfileViewController.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import AsyncDisplayKit

class UserProfileViewController: ASDKViewController<ASDisplayNode> {

    let viewModel: RepositoryViewModel
    
    init(viewModel: RepositoryViewModel) {
        self.viewModel = viewModel
        super.init(node: ASDisplayNode())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
