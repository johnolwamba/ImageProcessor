//
//  ImagesRemoteDataSource.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import RxSwift

class ImagesRemoteDataSource: BaseRemoteDataSource {
    func getImages() -> Single<[Image]> {
        return Single.create { [unowned self] single -> Disposable in
            self.getImages().subscribe(onSuccess: { response, _ in
                print(response)
                single(.success(response))
            }, onError: { error in
                print(error.localizedDescription)
                single(.error(error))
            })
        }
    }
    
    private func getImages() -> Single<([Image], HTTPURLResponse)> {
        let urlRequest = URLRequest(.images, .get)
        return apiRequest(urlRequest)
    }
}
