//
//  App.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/19/23.
//

import UIKit

final class App: AppRouter {
    
    private var coordinatorRegister: [AppTransition: Coordinator] = [:]
    
    var navController: UINavigationController = .init()
    
    func process(route: AppTransition) {
        let coordinator = route.hasState ? coordinatorRegister[route] : route.coordinatorFor(router: self)
        coordinatorRegister[route] = coordinator
        coordinator?.start()
        print(route.identifier)
    }
        
    func exit() {
        navController.popToRootViewController(animated: true)
    }
}

extension App: Coordinator {
    func start() {
        process(route: .showTopicList)
    }
}
