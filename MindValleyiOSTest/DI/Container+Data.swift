//
//  Container+Data.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/08/2019.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation
import Swinject

extension Container {
    public func registerDataDependencies() {
        registerRepositories()
    }
    
    // MARK: Use Cases DI
    private func registerRepositories() {
        register(ImageRepositoryProtocol.self) { _ in
            ImageRepository()
        }
    }
}
