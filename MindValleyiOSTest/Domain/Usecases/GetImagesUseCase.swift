//
//  GetImagesUseCase.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import RxSwift

public class GetImagesUseCase {
    private let imageRepository: ImageRepositoryProtocol
    
    init(_ imageRepository: ImageRepositoryProtocol) {
        self.imageRepository = imageRepository
    }
    
    func invoke() -> Single<[Image]> {
        return imageRepository.getImages()
    }
}
