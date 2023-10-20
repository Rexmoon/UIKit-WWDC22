//
//  HomeListCoordinator.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/19/23.
//

import UIKit

final class HomeListCoordinator<R: AppRouter> {
    
    private let router: R
    
    private lazy var primaryViewController: UIViewController = {
        let viewModel = HomeListViewModel(router: router)
        let viewController = HomeListCollectionViewController(viewModel: viewModel)
        return viewController
    }()
    
    init(router: R) {
        self.router = router
    }
}

extension HomeListCoordinator: Coordinator {
    
    func start() {
        router.navController.pushViewController(primaryViewController, animated: true)
    }
}
