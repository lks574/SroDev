//
//  HomeTableNodeDataSource.swift
//  TextureSample
//
//  Created by sro on 2020/12/07.
//

import AsyncDisplayKit

class HomeTableNodeDataSource: NSObject, ASTableDataSource {
    var reloadTableView: (() -> Void)?
    private var dataSource: BaseDataSource?
    
    func fetchDataFromLocalPath() {
        reloadTableView?()
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataSource?.newsFeed?.count ?? 0
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
    }
}
