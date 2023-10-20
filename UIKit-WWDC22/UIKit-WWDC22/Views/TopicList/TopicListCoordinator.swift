//
//  HomeListCoordinator.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/19/23.
//

import UIKit

final class TopicListCoordinator<R: AppRouter> {
    
    private let router: R
    
    private lazy var primaryViewController: UIViewController = {
        let viewModel = TopicListViewModel(router: router)
        let viewController = TopicListCollectionViewController(viewModel: viewModel)
        return viewController
    }()
    
    init(router: R) {
        self.router = router
    }
}

extension TopicListCoordinator: Coordinator {
    
    func start() {
        router.navController.pushViewController(primaryViewController, animated: true)
    }
}
