//
//  AppTransition.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/19/23.
//

enum AppTransition {
    case showHomeList
    
    var identifier: String { String(describing: self) }
    
    var hasState: Bool { false }
    
    func coordinatorFor<R: AppRouter>(router: R) -> Coordinator {
        switch self {
            case .showHomeList: return HomeListCoordinator(router: router)
        }
    }
}
