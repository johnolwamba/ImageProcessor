//
//  DependencyInjection.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/08/2019.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Swinject

class DependencyInjection {
    private var container: Container
    static let shared = DependencyInjection()
    
    private init() {
        container = Container()
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = container.resolve(serviceType) else {
            fatalError("Missing dependencies")
        }
        return service
    }
    
    func registerAppDependencies() {
        container.registerDataDependencies()
        container.registerDomainDependencies()
        container.registerAppDependencies()
    }
}

