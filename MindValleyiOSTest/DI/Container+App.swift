//
//  Container+App.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/08/2019.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Swinject

extension Container {
    func registerAppDependencies() {
        registerViewModelDependencies()
    }
    
    private func registerViewModelDependencies() {
        self.register(HomeViewModel.self) { resolver in
            let useCase = resolver.resolve(GetImagesUseCase.self)!
            return HomeViewModel(useCase)
        }
    }
}
