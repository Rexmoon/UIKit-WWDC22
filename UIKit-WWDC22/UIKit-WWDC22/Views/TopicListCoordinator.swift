//
//  HomeListCoordinator.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/19/23.
//

import UIKit

final class TopicListCoordinator<R: AppRouter> {
    
    private var router: R
    
    private lazy var primaryViewController: UIViewController = {
        let viewModel = TopicListViewModel(router: self)
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

extension TopicListCoordinator: TopicRouter {
    var navController: UINavigationController {
        get { router.navController }
        set { router.navController = newValue }
    }
    
    func process(route: TopicTransition) {
        switch route {
            case .showPageControlDetail(let topic):
                let viewModel = TopicDetailPageControlViewModel(topic: topic)
                let viewController = TopicDetailPageControlViewController(viewModel: viewModel)
                router.navController.pushViewController(viewController, animated: true)
        }
    }
    
    func exit() {
        router.navController.popToRootViewController(animated: true)
    }
}
