//
//  CustomizingSheetCoordinator.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna 12/16/23.
//

import UIKit

final class CustomizingSheetCoordinator<R: AppRouter> {
    
    private var router: R
    private let topic: Topic
    
    init(router: R, topic: Topic) {
        self.router = router
        self.topic = topic
    }
    
    private lazy var customizingSheetViewModel: CustomizingSheetViewModel = {
        CustomizingSheetViewModel(router: self)
    }()
    
    private lazy var customizingSheeViewController: CustomizingSheetViewController = {
        CustomizingSheetViewController(viewModel: customizingSheetViewModel, topic: topic)
    }()
}

extension CustomizingSheetCoordinator: Coordinator {
    
    func start() {
        router.navController.pushViewController(customizingSheeViewController, animated: true)
    }
}

extension CustomizingSheetCoordinator: CustomizingSheetRouter {
    
    var navController: UINavigationController {
        get { router.navController }
        set { router.navController = newValue }
    }
    
    func process(route: CustomizingSheetTransition) {
        switch route {
            case .showSheet(let value):
                let viewController = SheetViewController()
                
                guard let sheetController = viewController.sheetPresentationController else { break }
                
                sheetController.detents = [
                    .custom(identifier: .none, resolver: { context in
                        context.maximumDetentValue * value
                    })
                ]
                
                router.navController.present(viewController, animated: true)
        }
    }
    
    func exit() { }
}
