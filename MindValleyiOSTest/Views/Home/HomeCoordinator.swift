//
//  HomeCoordinator.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import UIKit

class HomeCoordinator {
    var window: UIWindow?
    var navigationController: UINavigationController
    private var homeViewModel: HomeViewModel!
    
    init(_ window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        homeViewModel = DependencyInjection.shared.resolve(HomeViewModel.self)
        let homeViewController = HomeViewController(homeViewModel)
        navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.navigationBar.isTranslucent = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

