//
//  RepositoryViewModel.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import Foundation
import RxSwift
import RxCocoa

class RepositoryViewModel {
    
    // @INPUT
    let updateRepository = PublishRelay<Repository>()
    let updateUsername = PublishRelay<String?>()
    let updateDescription = PublishRelay<String?>()
    let openProfileRelay = PublishRelay<Void>()
    
    // @OUTPUT
    var username: Observable<String?>
    var profileURL: Observable<URL?>
    var desc: Observable<String?>
    var status: Observable<String?>
    var openProfile: Observable<Int>
    
    let id: Int
    let disposeBag = DisposeBag()
    
    deinit {
        RepoProvider.release(id: id)
    }
    
    init(repository: Repository) {
        self.id = repository.id
        
        RepoProvider.addAndUpdate(repository)
        
        let repoObserver = RepoProvider.observable(id: id)
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
        
        openProfile = openProfileRelay
            .subscribeOn(MainScheduler.asyncInstance)
            .withLatestFrom(repoObserver)
            .map { $0?.id ?? -1 }
        
        self.username = repoObserver
            .map { $0?.user?.username }
        
        self.profileURL = repoObserver
            .map { $0?.user?.profileURL }
        
        self.desc = repoObserver
            .map { $0?.desc }
        
        self.status = repoObserver
            .map { item -> String? in
                var statusArray: [String] = []
                if let isForked = item?.isForked, isForked {
                    statusArray.append("Forked")
                }
                
                if let isPrivate = item?.isPrivate, isPrivate {
                    statusArray.append("Private")
                }
                
                return statusArray.isEmpty ? nil : statusArray.joined(separator: " · ")
            }
    
        self.updateRepository.subscribe(onNext: { newRepo in
            RepoProvider.update(newRepo)
        }).disposed(by: disposeBag)
        
        updateUsername.withLatestFrom(repoObserver) { ($0, $1) }
            .subscribe(onNext: { text, repo in
                guard let repo = repo else { return }
                repo.user?.username = text ?? ""
                RepoProvider.update(repo)
            }).disposed(by: disposeBag)
        
        updateDescription.withLatestFrom(repoObserver) { ($0, $1) }
            .subscribe(onNext: { text, repo in
                guard let repo = repo else { return }
                repo.desc = text
                RepoProvider.update(repo)
            }).disposed(by: disposeBag)
        
        // 변경 전
//        repoObserver
//            .map { $0?.user?.username }
//            .bind(to: username)
//            .disposed(by: disposeBag)
//
//        repoObserver
//            .map { $0?.user?.profileURL }
//            .bind(to: profileURL)
//            .disposed(by: disposeBag)
//
//        repoObserver
//            .map { $0?.desc }
//            .bind(to: desc)
//            .disposed(by: disposeBag)
//
//        repoObserver
//            .map { item -> String? in
//                var statusArray: [String] = []
//                if let isForked = item?.isForked, isForked {
//                    statusArray.append("Forked")
//                }
//
//                if let isPrivate = item?.isPrivate, isPrivate {
//                    statusArray.append("Private")
//                }
//
//                return statusArray.isEmpty ? nil: statusArray.joined(separator: " · ")
//            }.bind(to: status)
//            .disposed(by: disposeBag)
//
//        self.updateRepository.subscribe(onNext: { newRepo in
//            RepoProvider.update(newRepo)
//        }).disposed(by: disposeBag)
//
//        updateUsername.withLatestFrom(repoObserver) { ($0, $1) }
//            .subscribe(onNext: { text, repo in
//                guard let repo = repo else { return }
//                repo.user?.username = text ?? ""
//                RepoProvider.update(repo)
//            }).disposed(by: disposeBag)
//
//        updateDescription.withLatestFrom(repoObserver) { ($0, $1) }
//            .subscribe(onNext: { text, repo in
//                guard let repo = repo else { return }
//                repo.desc = text
//                RepoProvider.update(repo)
//            }).disposed(by: disposeBag)
//
//        updateProfileImage.withLatestFrom(repoObserver) { ($0, $1) }
//            .subscribe(onNext: { url, repo in
//                guard let repo = repo else { return }
//                repo.user?.profileURL = url
//                RepoProvider.update(repo)
//            }).disposed(by: disposeBag)
        
    }
}
