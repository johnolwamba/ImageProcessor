//
//  ImageRepository.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import RxSwift

class ImageRepository: ImageRepositoryProtocol {
    private let imagesRemoteDataSource = ImagesRemoteDataSource()
    
    init() {}
    
    func getImages() -> Single<[Image]> {
        return imagesRemoteDataSource.getImages()
    }
}
