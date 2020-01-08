//
//  Container+Domain.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/08/2019.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation
import Swinject

extension Container {
    public func registerDomainDependencies() {
        registerUseCases()
    }
    
    // MARK: Use Cases DI
    // swiftlint:disable function_body_length
    private func registerUseCases() {
        self.register(GetImagesUseCase.self) { resolver in
            
            let repository = resolver.resolve(ImageRepositoryProtocol.self)!
            let useCase = GetImagesUseCase(repository)
            return useCase
        }
    }
}
