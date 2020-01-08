//
//  ApplicationCoordinator.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import RxSwift

class ApplicationCoordinator {
    private let window: UIWindow?
    private let disposeBag = DisposeBag()
    
    required init(_ window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        self.startHome()
    }
    
    private func startHome() {
        guard let window = window else {
            return
        }
        HomeCoordinator(window).start()
    }
}

