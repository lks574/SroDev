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
        dataSource = Bundle.main.decode(BaseDataSource.self, from: localJSONFile)
        dataSource?.newsFeed?.shuffle()
        if let _ = dataSource{
            reloadTableView?()
        }else{
            fatalError("Couldn't get data from bundle extension")
        }
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.newsFeed?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            let item = self?.dataSource?.newsFeed?[indexPath.row]
            let cell = FeedCellNode(feed: item)
            return cell
        }
    }
}
