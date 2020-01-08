//
//  HomeViewModel.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    private let getImagesUseCase: GetImagesUseCase
    private let imagesBehaviorRelay = BehaviorRelay<[Any]>(value: [])
    private let emptyScreenPublishRelay = PublishRelay<Bool>()
    private var images: [Image] = []
    
    var dataSource: Observable<[Any]> {
        return imagesBehaviorRelay.asObservable()
    }
    var emptyScreen: Observable<Bool> {
        return imagesBehaviorRelay.asObservable().map({ images in
            images.isEmpty
        })
    }
    
    init(_ getImagesUseCase: GetImagesUseCase) {
        self.getImagesUseCase = getImagesUseCase
    }
    
    func fetch() {
        getImagesUseCase.invoke().subscribe(onSuccess: { [weak self] images in
            guard let self = self else { return }
            self.images = images
            let uiModels = images.map { image -> HomeTableViewCell.UIModel in
                HomeTableViewCell.UIModel(likes: image.likes, username: image.user.username, categories: image.category, imageUrl: image.urls.full)
            }
            self.imagesBehaviorRelay.accept(uiModels)
        }) { [weak self] error in
            guard let self = self else { return }
            self.handleError(error, self.fetch)
        }.disposed(by: disposeBag)
    }
}

