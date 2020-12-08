//
//  ImageDownloader.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import Foundation
import RxSwift
import RxCocoa

struct ImageDownloader {
    
    // fake image download
    static func download() -> Observable<URL?> {
        return Observable<URL?>.create({ operation in
            let url = URL(string: "https://avatars1.githubusercontent.com/u/19504988?s=460&v=4")
            DispatchQueue.global().async {
                operation.onNext(url)
                operation.onCompleted()
            }
            return Disposables.create()
        })
    }
}
