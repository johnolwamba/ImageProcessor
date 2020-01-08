//
//  ImageRepositoryProtocol.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import RxSwift

protocol ImageRepositoryProtocol {
    func getImages() -> Single<[Image]>
}
