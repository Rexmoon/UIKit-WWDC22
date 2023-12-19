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
                let viewModel = PageControlDetailViewModel(topic: topic)
                let viewController = PageControlDetailViewController(viewModel: viewModel)
                router.navController.pushViewController(viewController, animated: true)
                
            case .showResizingViewDetail(let topic):
                let viewModel = ResizingCellsDetailViewModel(topic: topic)
                let viewController = ResizingCellsDetailViewController(viewModel: viewModel)
                router.navController.pushViewController(viewController, animated: true)
                
            case .showHostingConfigurationViewDetail(let topic):
                let viewModel = HostingConfigurationViewModel(topic: topic)
                let viewController = HostingConfigurationViewController(viewModel: viewModel)
                router.navController.pushViewController(viewController, animated: true)
                
            case .showCustomizingSheet(let topic):
                router.process(route: .showCustomizingSheet(topic))
                
            case .showSFSymbol(let topic): 
                let viewController = SFSymbolViewController(topic: topic)
                router.navController.pushViewController(viewController, animated: true)
        }
    }
    
    func exit() {
        router.navController.popToRootViewController(animated: true)
    }
}
